#!/usr/bin/python
"""
Apply transform for CNXML 0.6 to 0.7 upgrade to all files in this dir 
and its subdir matching the regular expression (presumed to be the 
test docs).
"""

import os
import re
from lxml import etree

fNameRegex = re.compile(r'^[mb]\d+\.xml$')
fixAllXslt = etree.XSLT(etree.parse(open('cnxml06to07.xsl')))

for dPath, dNames, fNames in os.walk('.'):
    for fName in filter(fNameRegex.match, fNames):
        inFile = open(os.path.join(dPath, fName), 'r+')
        xsltResult = fixAllXslt(etree.parse(inFile))
        inFile.seek(0)
        inFile.truncate()
        inFile.write(str(xsltResult))
        inFile.close()
