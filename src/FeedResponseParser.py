#!/usr/bin/env python3
# coding: utf8
import requests
#import xmltodict
import re
import sys
from FileReader import FileReader
import pprint
import feedparser
class FeedResponseParser:
    def parse(self, xml_text):
#        xml = xmltodict.parse(xml_text)
#        pprint.pprint(xml)
#        print(xml['rdf:RDF']['item']['title'])
        feed = feedparser.parse(xml_text)
#        pprint.pprint(len(feed['entries']))
        for entry in feed['entries']:
            print(f"{self._get_image_id(entry['hatena_syntax'])}\t{entry['hatena_imagewidth']}\t{entry['hatena_imageheight']}\t{entry['title']}")
    def _get_image_id(self, hatena_syntax):
        return re.search(r'([0-9]{14,}[pjg]):image$', hatena_syntax).group(1)
    def _get_image_datetime(self, hatena_syntax):
        return re.search(r'([0-9]{14,})[pjg]:image$', hatena_syntax).group(1)

def parse_command():
    xml_text = None
    if 1 < len(sys.argv):
        xml_text = FileReader.text(sys.argv[1])
    else:
        xml_text = sys.stdin.read().rstrip('\r\n')
    return xml_text

if __name__ == '__main__':
    FeedResponseParser().parse(parse_command())

