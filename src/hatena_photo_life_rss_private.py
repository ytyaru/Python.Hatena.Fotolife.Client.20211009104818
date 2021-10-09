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
from login import Login
# はてなフォトライフの任意フォルダのうち公開範囲が「自分のみ」のフォルダを閲覧する。
# そのためにはログインせねばならない。パスワードが必要。
class HatenaPhotoLifeRssPrivate:
    def __init__(self, login):
        self.__login = login
    @classmethod
    def from_json(self, path, schema_path=None):
        login = Login()
        login.login_from_json('https://www.hatena.ne.jp/login', path, schema_path)
        return HatenaPhotoLifeRssPrivate(login)
    def get(self, folder:str=None, page:int=1, is_sort_old:bool=False, is_logging:bool=False):
        folder = f'/{urllib.parse.quote(folder)}' if folder else ''
        page = f"page={page if 0 < page else 1}"
        is_sort_old = f"sort={'old' if is_sort_old else 'new'}"
#        url = f'https://f.hatena.ne.jp/{self.__hatena_id}{folder}/rss?{page}&{is_sort_old}'
        url = f'https://f.hatena.ne.jp/{self.__login.Username}{folder}/rss?{page}&{is_sort_old}'
        if is_logging: print(f'{url}', file=sys.stderr)
        print(f'{url}', file=sys.stderr)
        return self.__login.open(url)
#        return requests.get(url)

if __name__ == '__main__':
    rss = HatenaPhotoLifeRssPrivate.from_json(Path.here('secret.json'))
#    rss.get()
#    rss.get('')
    rss.get('Hatena Blog')
#    rss.get('日本語')
