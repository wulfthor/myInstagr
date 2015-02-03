#!/usr/bin/python
# -*- coding: utf-8 -*-
from __future__ import unicode_literals
import os
import sys
import locale
import re
import pdb
import unicodedata
import codecs
import json

#################################################
# TODO
# regex word is not working for unicode chars
#
#print locale.getdefaultlocale()
#print sys.getdefaultencoding()
reload(sys);
sys.setdefaultencoding("utf8")
#print sys.getdefaultencoding()
#
#  "id": "412161964",  "name": "Smk Fridays"
#################################################

fh=open(sys.argv[1])
#reg=re.compile('.*"id.*?([0-9]+)",\s*"\w+": "([a-zøæåA-ZÆØÅ\s]+)"')
reg=re.compile('.*"id.*?([0-9]+)",\s*"\w+": "([\D\s]+)"')

lines=fh.readlines()
tmpArr = []
idArr = []
idNameDict = dict()

for line in lines:
  #pdb.set_trace()
  m=reg.search(line)
  if m:
    if m.group(1) in idNameDict.keys():
      idNameDict[m.group(1)].append(m.group(2))
      #print "append " + m.group(2)
    else:
      tmpL=[]
      tmpL.append(m.group(2))
      idNameDict[m.group(1)]=tmpL
      #print "new key " + m.group(1)
      #print "new val " + m.group(2)
  #else:
  #  print "regex failed " + line

print json.dumps(idNameDict)
