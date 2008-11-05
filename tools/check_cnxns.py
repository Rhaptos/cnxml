#!/usr/bin/python

import sys
import os
from xml import sax
from lxml import etree
import lxml.sax
import urllib2
import pdb
"""
    SAX content handler to compare document and element IDs, and cnxns 
    pointing to those documents and elements, in a body of CNXML modules.
    For now we assume that the CNXML files are named 'index.cnxml' and are 
    in directories whose names are the module ID, and that these directories 
    are descendants of the first arg given to the progrem.  However, I want
    to make this program work for CNXML 0.6 as well, so I'll need to fancy up
    the opts at some point.

    I use lxml because it make use of libxml2, which in turn makes use of OASIS
    XML catalogs.  expat doesn't, and it will either retrieve all the DTDs 
    over the network for each document, or it will fail on certain valid 
    documents because it can't make sense of entity references.

    Output and reporting not done yet.
"""

class TrackCnxnsAndIds(sax.handler.ContentHandler):

    def __init__(self):
        self.moduleId = None
        # elementIds = {
        #   <sourceModId> : {
        #     <elemId> : <elemName>
        #   }
        # }
        self.elementIds = {}
        # thisDocElementIds = {
        #   <elemId> : <elemName>
        # }
        self.thisDocElementIds = {}
        # pendingCnxns = {
        #   <targetModId> : [ (<sourceModId>, <targetElemId>) ... ]
        # }
        self.pendingCnxns = {}
        # badCnxns = {
        #   <sourceModId> : {
        #     <targetModId> : [ (<@document>, <@target>), ... ]
        #   }
        # }
        self.badCnxns = {}
        sax.handler.ContentHandler.__init__(self)

    def startDocument(self):
        self.thisDocElementIds = {}
        self.badCnxns[self.moduleId] = {}

    def endDocument(self):
        # Move elements and IDs from this doc to the accumulator
        self.elementIds[self.moduleId] = self.thisDocElementIds
        # Process any cnxns pending for this module
        for sourceModuleId, targetElementId in self.pendingCnxns.get(self.moduleId, []):
            # cnxn points to an ID, but there is no element with this ID 
            # registered for the target doc: a bad cnxn: add to badCnxns
            if targetElementId and not self.elementIds.get(self.moduleId, {}).get(targetElementId):
                self.appendToBad(sourceModuleId, self.moduleId, targetElementId)
        if self.pendingCnxns.has_key(self.moduleId):
            del self.pendingCnxns[self.moduleId]

    def startElementNS(self, name, qname, attrs):
        elementId = attrs.get((None, 'id'))
        if elementId and qname != 'document':
            self.thisDocElementIds[elementId] = name[1]
        if name == ('http://cnx.rice.edu/cnxml', 'cnxn'):
            self.handleCnxns(attrs)

    def handleCnxns(self, attrs):
        document = attrs.get((None, 'document'), '').strip()
        if document:
            target_document = document
        else:
            target_document = self.moduleId
        target = attrs.get((None, 'target'), '').strip()
        if target:
            #pdb.set_trace()
            if self.elementIds.has_key(target_document) and not self.elementIds[target_document].has_key(target):
                self.appendToBad(self.moduleId, target_document, target)
            elif not self.elementIds.has_key(target_document):
                self.appendToPending(self.moduleId, target_document, target)
        elif document and not self.elementIds.has_key(document):
            self.appendToPending(self.moduleId, target_document, target)

    def endElementNS(self, name, qname):
        pass

    def appendToBad(self, sourceModuleId, targetModuleId, targetElementId):
        if self.badCnxns[sourceModuleId].has_key(targetModuleId):
            self.badCnxns[sourceModuleId][targetModuleId].append((targetModuleId, targetElementId))
        else:
            self.badCnxns[sourceModuleId][targetModuleId] = [(targetModuleId, targetElementId)]

    def appendToPending(self, sourceModuleId, targetModuleId, targetElementId):
        if self.pendingCnxns.has_key(targetModuleId):
            self.pendingCnxns[targetModuleId].append((sourceModuleId, targetElementId))
        else:
            self.pendingCnxns[targetModuleId] = [(sourceModuleId, targetElementId)]

    def cleanup(self):
        for k, v in self.badCnxns.items():
            if v == {}: del self.badCnxns[k]


class CnxnIdParser(object):

    def __init__(self):
        self.parser = sax.make_parser()
        self.parser.setContentHandler(TrackCnxnsAndIds())
        self.parser.setFeature(sax.handler.feature_external_pes, False)
        self.parser.setFeature(sax.handler.feature_external_ges, False)
        self.parser.setFeature(sax.handler.feature_namespaces, True)
        self.parser.setFeature(sax.handler.feature_namespace_prefixes, True)
        self.moduleId = None

    def parse(self, source):
        self.parser.getContentHandler().moduleId = self.moduleId
        try:
            self.parser.parse(source)
        except sax._exceptions.SAXParseException:
            sys.stderr.write("Skipping %s (cannot parse without DTD).\n" % self.moduleId)

    def getContentHandler(self):
        return self.parser.getContentHandler()

    def lastDocIds(self):
        lastDoc = self.parser.getContentHandler().elementIds.values()[-1]
        for k, v in lastDoc.items():
            print "%s\t%s" % (k,v)

    def lastDocCnxns(self):
        #lastDoc = self.parser.getContentHandler().pendingCnxns.values()[-2]
        #for k, v in lastDoc:
        #    print "%s\t%s" % (k,v)
        #pdb.set_trace()
        for k,v in self.parser.getContentHandler().pendingCnxns.items():
            if len(v):
                print self.moduleId
                for cnxn in v:
                    print cnxn

if __name__ == '__main__':
    ch = TrackCnxnsAndIds()
    start_dir = sys.argv[1]
    i = 0
    for dpath, dnames, fnames in os.walk(start_dir):
        for fname in fnames:
            if fname == 'index.cnxml':
                ch.moduleId = os.path.split(dpath)[-1]
                lxml.sax.saxify(lxml.etree.parse(os.path.join(dpath, fname)), ch)
                i += 1
                if i == 1000:
                    break
        if i == 1000:
            break
    ch.cleanup()
    print ch.badCnxns.keys()
