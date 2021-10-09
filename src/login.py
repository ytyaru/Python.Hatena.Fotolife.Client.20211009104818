#!/usr/bin/env python3
# coding: utf8
import os, sys
import jsonschema
from path import Path
from FileReader import FileReader 
from secret import Secret
import urllib.request
from http.cookiejar import CookieJar
import urllib.parse
import pprint
class Login:
    def __init__(self):
        self.opener = None
        self.__username = None
    def login_from_json(self, url, path, schema_path=None):
        secret = Secret.from_json(path, schema_path)
        if 'password' not in secret: raise ValueError(f'[ERROR] password がありません。指定したファイルにセットしてください。: {path}')
        self.login(url, secret['username'], secret['password'])
    def _get_secret_from_json(self, url, path, schema_path=None):
        secret = FileReader.json(path)
        if schema_path:
            schema = FileReader.json(schema_path)
            try: jsonschema.validate(secret, schema)
            except jsonschema.ValidationError as e:
                print(f'[ERROR] スキーマ違反です。\n{path}\n{schema_path}', file=sys.stderr)
                print(e, file=sys.stderr)
                raise e
        if 'password' not in secret: raise ValueError(f'[ERROR] password がありません。指定したファイルにセットしてください。: {path}')
        return secret
        self._make_login_data(secret['username'], secret['password'])
        
    def _make_login_data(self, username, password):
        data = {
            'name': username,
            'password': password
        }
        return urllib.parse.urlencode(data).encode('utf-8')
    def login(self, url, username, password):
        self.__username = username
        self.opener = urllib.request.build_opener(urllib.request.HTTPCookieProcessor(CookieJar()))
#        self.opener = urllib.request.build_opener(HTTPCookieProcessor(CookieJar()))
        # https://www.hatena.ne.jp/login
#        res = self.opener.open(url, data)
        res = self.opener.open(url, self._make_login_data(username, password))
#        res = self.opener.open('https://www.hatena.ne.jp/login', data)
#        pprint.pprint(res.getheaders(), file=sys.stderr)
        print(res.getheaders(), file=sys.stderr)
        res.close()
#        with self.opener.open(url) as res:
#            return res.read()
#        with self.opener.open(url, data) as res:
#            pprint.pprint(res.getheaders(), file=sys.stderr)

    def open(self, url):
        print('*********************')
        with self.opener.open(url) as res:
            print(res)
            print(res.read())
            return res.read()

    @property
    def Username(self): return self.__username
