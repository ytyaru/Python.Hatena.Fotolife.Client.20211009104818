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
    def parse(self, args):
#        xml = xmltodict.parse(xml_text)
#        pprint.pprint(xml)
#        print(xml['rdf:RDF']['item']['title'])
        feed = feedparser.parse(args['xml_text'])
        if args['add_header']:
            total = self._blank_to_zero(feed['feed']['opensearch_totalresults'])
            start = self._blank_to_zero(feed['feed']['opensearch_startindex'])
            per_page = self._blank_to_zero(feed['feed']['opensearch_itemsperpage'])
#            total = int(feed['feed']['opensearch_totalresults'])
#            start = int(feed['feed']['opensearch_startindex'])
#            per_page = int(feed['feed']['opensearch_itemsperpage'])
            page_num = (total // per_page) + (0 if 0 == total % per_page else 1)
            print('\t'.join([str(v) for v in [total, start, per_page, page_num]]))
#            print(f"{total}\t{start}\t{per_page}\t{page_num}")
#        pprint.pprint(feed['feed']['opensearch_totalresults'])
#        pprint.pprint(feed['feed']['opensearch_startindex'])
#        pprint.pprint(feed['feed']['opensearch_itemsperpage'])
#opensearch_totalresults
#opensearch_startindex
#opensearch_itemsperpage
#        pprint.pprint(len(feed['entries']))
        for entry in feed['entries']:
            print(f"{self._get_image_id(entry['hatena_syntax'])}\t{entry['hatena_imagewidth']}\t{entry['hatena_imageheight']}\t{entry['title']}")
    def _blank_to_zero(self, v):
        return int(v) if v else 0
    def _get_image_id(self, hatena_syntax):
        res = re.search(r'([0-9]{14,}[pjg]):image$', hatena_syntax)
        if res: return res.group(1)
        #f:id:ytyaru:20161108160742f:movie
        res = re.search(r'([0-9]{14,}[f]):movie$', hatena_syntax)
        if res: return res.group(1)
        print(f'[WARN] 画像IDを取得できませんでした。代わりにシンタックスを返します。{hatena_syntax}', file=sys.stderr)
        return hatena_syntax
    def _get_image_datetime(self, hatena_syntax):
        id = self._get_image_id(hatena_syntax)
        if id == hatena_syntax: return hatena_syntax
        else: return id[:-1]

def parse_command():
    args = {}
    args['xml_text'] = None
    if 1 < len(sys.argv) and '-H' != sys.argv[1]:
        args['xml_text'] = FileReader.text(sys.argv[1])
    else:
        args['xml_text'] = sys.stdin.read().rstrip('\r\n')
    args['add_header'] = True if '-H' in sys.argv else False
    return args

if __name__ == '__main__':
    FeedResponseParser().parse(parse_command())

