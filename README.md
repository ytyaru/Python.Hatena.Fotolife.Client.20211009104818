[ja](./README.ja.md)

# Hatena.Fotolife.Client

Hatena Photo Life API client.

# Requirement

* <time datetime="2021-10-09T10:47:44+0900">2021-10-09</time>
* [Raspbierry Pi](https://ja.wikipedia.org/wiki/Raspberry_Pi) 4 Model B Rev 1.2
* [Raspberry Pi OS](https://ja.wikipedia.org/wiki/Raspbian) buster 10.0 2020-08-20 <small>[setup](http://ytyaru.hatenablog.com/entry/2020/10/06/111111)</small>
* bash 5.0.3(1)-release
* Python 2.7.16
* Python 3.7.3

```sh
$ uname -a
Linux raspberrypi 5.10.52-v7l+ #1441 SMP Tue Aug 3 18:11:56 BST 2021 armv7l GNU/Linux
```

# Installation

```sh
git clone https://github.com/ytyaru/Python.Hatena.Fotolife.Client.20211009104818
cd Python.Hatena.Fotolife.Client.20211009104818
pip3 install -r requirements.txt
```

# Usage

```sh
cd src
./run.py
```

```sh
usage: run.py [-h] [-l] {post,set-title,delete,get,feed} ...

画像をアップロードする。はてなフォトライフへ。 0.0.1

positional arguments:
  {post,set-title,delete,get,feed}
    post                アップロードする。`post -h`
    set-title           タイトルを変更する。`set-title -h`
    delete              削除する。see `delete -h`
    get                 取得する。`get -h`
    feed                全データから指定した範囲内で最大50件取得する。`feed -h`

optional arguments:
  -h, --help            show this help message and exit
  -l, --logging         StdErrにログ出力する
```

## post

```sh
$ post -h
usage: run.py post [-h] [-t TITLE] [-f FOLDER] [-g GENERATOR]
                   [-p RESPONSE_PARSER]
                   path

positional arguments:
  path                  画像ファイルパス

optional arguments:
  -h, --help            show this help message and exit
  -t TITLE, --title TITLE
                        画像のタイトル（初期値＝pathのファイル名）
  -f FOLDER, --folder FOLDER
                        アップロード先のフォルダ名
  -g GENERATOR, --generator GENERATOR
                        アップロードしたツール名（フォルダ振分用）
  -p RESPONSE_PARSER, --response-parser RESPONSE_PARSER
                        API応答パーサのパス（LinedResponseParser.py）
```

## set-title

```sh
$ set-title -h
usage: run.py set-title [-h] image_id title

positional arguments:
  image_id    画像ID（yyyyMMddHHmmss）
  title       タイトル

optional arguments:
  -h, --help  show this help message and exit
```

## delete

```sh
$ delete -h
usage: run.py delete [-h] image_id

positional arguments:
  image_id    画像ID（yyyyMMddHHmmss）

optional arguments:
  -h, --help  show this help message and exit
```

## get

```sh
$ get -h
usage: run.py get [-h] image_id

positional arguments:
  image_id    画像ID（yyyyMMddHHmmss）

optional arguments:
  -h, --help  show this help message and exit
```

## feed

```sh
$ feed -h
usage: run.py feed [-h] [-f FOLDER] [-p PAGE] [-o]

optional arguments:
  -h, --help            show this help message and exit
  -f FOLDER, --folder FOLDER
                        対象フォルダ名（未入力ならトップフォルダ）
  -p PAGE, --page PAGE  対象ページ（未入力なら1）
  -o, --sort_old        古い順にソートする
```

## tools

Files|概要
-----|----
[PostResponseParser.py][]|postした応答をパースする。
[FeedResponseParser.py][]|feedした応答をパースする。

[PostResponseParser.py]:https://github.com/ytyaru/Python.Hatena.Fotolife.Client.20211009104818/src/
[FeedResponseParser.py]:https://github.com/ytyaru/Python.Hatena.Fotolife.Client.20211009104818/src/

## example

* [example.sh][]

[example.sh]:https://github.com/ytyaru/Python.Hatena.Fotolife.Client.20211009104818/usage/example.sh

## others

* [usage/](https://github.com/ytyaru/Python.Hatena.Fotolife.Client.20211009104818/usage)

Files|概要
-----|----
[all_id_marge.sh][]|指定したフォルダの全画像IDを取得する。（既存最新IDより古いものは取得しない）
[all_id_get.sh][]|指定したフォルダの全画像IDを取得する。
[id2urls.sh][]|画像ID一覧ファイルからURL一覧ファイルを生成する。
[id2url.sh][]|画像IDからURLを生成する。

[all_id_marge.sh]:https://github.com/ytyaru/Python.Hatena.Fotolife.Client.20211009104818/usage/all_id_marge.sh
[all_id_get.sh]:https://github.com/ytyaru/Python.Hatena.Fotolife.Client.20211009104818/usage/all_id_get.sh
[id2urls.sh]:https://github.com/ytyaru/Python.Hatena.Fotolife.Client.20211009104818/usage/id2urls.sh
[id2url.sh]:https://github.com/ytyaru/Python.Hatena.Fotolife.Client.20211009104818/usage/id2url.sh

# Author

ytyaru

* [![github](http://www.google.com/s2/favicons?domain=github.com)](https://github.com/ytyaru "github")
* [![hatena](http://www.google.com/s2/favicons?domain=www.hatena.ne.jp)](http://ytyaru.hatenablog.com/ytyaru "hatena")
* [![mastodon](http://www.google.com/s2/favicons?domain=mstdn.jp)](https://mstdn.jp/web/accounts/233143 "mastdon")

# License

This software is CC0 licensed.

[![CC0](http://i.creativecommons.org/p/zero/1.0/88x31.png "CC0")](http://creativecommons.org/publicdomain/zero/1.0/deed.en)

