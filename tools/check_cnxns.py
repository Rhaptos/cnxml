#!/usr/bin/python

import sys
import os
import codecs
from xml import sax
from lxml import etree
import lxml.sax
import urllib2
import getopt
import re
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

    Output and reporting not finished yet.
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
        elif name == ('http://cnx.rice.edu/cnxml', 'link') and \
                attrs.get((None, 'class'), '') == 'cnxn':
            self.handleCnxns(attrs)

    def handleCnxns(self, attrs):
        document = attrs.get((None, 'document'), '').strip()
        if document:
            target_document = document
        else:
            target_document = self.moduleId
        if attrs.has_key((None, 'target')):
            target = attrs.get((None, 'target'), '').strip()
        else:
            target = attrs.get((None, 'target-id'), '').strip()
        if target:
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

    def cleanup(self, movePending=True):
        if movePending:
            for targetModuleId, targetList in self.pendingCnxns.items():
                for sourceModuleId, targetElementId in targetList:
                    self.appendToBad(sourceModuleId, targetModuleId, targetElementId)
        for k, v in self.badCnxns.items():
            if v == {}: del self.badCnxns[k]


if __name__ == '__main__':
    cnxml06_regex = re.compile(r'^(?P<moduleId>m\d+).xml$')
    optz, argz = getopt.getopt(sys.argv[1:], '6')
    cnxmlVersion = '0.5'
    if ('-6', '') in optz:
        cnxmlVersion = '0.6'
    ch = TrackCnxnsAndIds()
    start_dir = argz[0]
    i = 0
    upper = 10000
    for dpath, dnames, fnames in os.walk(start_dir):
        for fname in fnames:
            if fname == 'index.cnxml' and cnxmlVersion != '0.6':
                ch.moduleId = os.path.split(dpath)[-1]
                lxml.sax.saxify(lxml.etree.parse(os.path.join(dpath, fname)), ch)
                i += 1
                if i == upper:
                    break
            elif cnxmlVersion == '0.6':
                moduleId = None
                m = cnxml06_regex.match(fname)
                if m:
                    moduleId = m.group('moduleId')
                if moduleId:
                    ch.moduleId = moduleId
                    lxml.sax.saxify(lxml.etree.parse(os.path.join(dpath, fname)), ch)
                i += 1
                if i == upper:
                    break
        if i == upper:
            break
    ch.cleanup(movePending=True)
    sourceModuleIds = ch.badCnxns.keys()
    sourceModuleIds.sort()
    badfile = open('./bad_cnxns.csv', 'w')
    for sourceModuleId in sourceModuleIds:
        for targetModuleId, targetList in ch.badCnxns[sourceModuleId].items():
            for targetDoc, targetElementId in targetList:
                badfile.write("%s\t%s\t%s\n" % (sourceModuleId, targetDoc, targetElementId))
    badfile.close()

    elementsfile = codecs.open('./elementsids.csv', 'w', 'utf-8')
    for sourceModuleId in ch.elementIds.keys():
        for elementId, elementName in ch.elementIds[sourceModuleId].items():
            elementsfile.write("%s\t%s\t%s\n" % (sourceModuleId, elementId, elementName))
