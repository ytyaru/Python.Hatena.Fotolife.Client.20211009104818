#!/usr/bin/env python3
# coding: utf8
import requests
import xmltodict
import re
import os, sys
class PostResponseParser:
    def parse(self, xml_text):
        xml = xmltodict.parse(xml_text)

        print(xml['entry']['title'])
        print(xml['entry']['issued'])
        print(xml['entry']['author']['name'])
#       print(xml['entry']['dc:subject']['#text'])
#       print(xml['entry']['generator']['#text'])
        print(xml['entry']['hatena:imageurl'])
        print(xml['entry']['hatena:imageurlmedium'])
        print(xml['entry']['hatena:imageurlsmall'])
        print(xml['entry']['hatena:syntax'])
        print(self._get_image_id(xml['entry']['hatena:syntax']))
        print(self._get_image_datetime(xml['entry']['hatena:syntax']))
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
    PostResponseParser().parse(parse_command())
       
