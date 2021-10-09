#!/usr/bin/env python3
# coding: utf8
import feedparser
import urllib.parse
import pprint
import os, sys
from base64 import b64encode
import requests
import mimetypes
import xmltodict
import pathlib
import jsonschema
from path import Path
from FileReader import FileReader 
# フォルダの公開範囲を「トップと同じ」にしないとRSSに反映されない
# https://f.hatena.ne.jp/ytyaru/%E6%97%A5%E6%9C%AC%E8%AA%9E/rss?page=1
# はてなフォトライフAtomAPIのFeedUriはトップフォルダのみ。RSSのURLを直接操作したほうが応用できる。
class HatenaPhotoLifeRss:
    def __init__(self, hatena_id):
        self.__hatena_id = hatena_id
    @classmethod
    def from_json(self, path, schema_path=None):
        secret = FileReader.json(path)
        if schema_path:
            schema = FileReader.json(schema_path)
            try: jsonschema.validate(secret, schema)
            except jsonschema.ValidationError as e:
                print('[ERROR] secret.json 形式エラーです。secret-schema.json に従ってください。', file=sys.stderr)
                print(e, file=sys.stderr)
                raise e
        return HatenaPhotoLifeRss(secret['username'])
    def get(self, folder:str=None, page:int=1, is_sort_old:bool=False, is_logging:bool=False):
        folder = f'/{urllib.parse.quote(folder)}' if folder else ''
        page = f"page={page if 0 < page else 1}"
        is_sort_old = f"sort={'old' if is_sort_old else 'new'}"
        url = f'https://f.hatena.ne.jp/{self.__hatena_id}{folder}/rss?{page}&{is_sort_old}'
        if is_logging: print(f'{url}', file=sys.stderr)
        return requests.get(url)

if __name__ == '__main__':
    rss = HatenaPhotoLifeRss('ytyaru')
    rss.get()
#    rss.get('')
#    rss.get('Hatena Blog')
#    rss.get('日本語')
