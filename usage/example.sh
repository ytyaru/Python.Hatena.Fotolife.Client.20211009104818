#!/usr/bin/env bash
set -Ceu
#---------------------------------------------------------------------------
# 使い方。
# CreatedAt: 2021-10-11
#---------------------------------------------------------------------------
Run() {
	THIS="$(realpath "${BASH_SOURCE:-0}")"; HERE="$(dirname "$THIS")"; PARENT="$(dirname "$HERE")"; THIS_NAME="$(basename "$THIS")"; APP_ROOT="$PARENT";
	cd "$HERE"
	post() {
		# POSTしたときに任意の情報を取得する
		cat '../test/test_data/test-4.xml' | '../src/PostResponseParser.py' | sed -n 1P 
		cat '../test/test_data/test-4.xml' | '../src/PostResponseParser.py' | sed -n 2P 
		cat '../test/test_data/test-4.xml' | '../src/PostResponseParser.py' | sed -n 3P 
		cat '../test/test_data/test-4.xml' | '../src/PostResponseParser.py' | sed -n 4P 
		cat '../test/test_data/test-4.xml' | '../src/PostResponseParser.py' | sed -n 5P 
		cat '../test/test_data/test-4.xml' | '../src/PostResponseParser.py' | sed -n 6P 
		cat '../test/test_data/test-4.xml' | '../src/PostResponseParser.py' | sed -n 7P 
		cat '../test/test_data/test-4.xml' | '../src/PostResponseParser.py' | sed -n 8P 
		cat '../test/test_data/test-4.xml' | '../src/PostResponseParser.py' | sed -n 9P 
		cat '../test/test_data/test-4.xml' | '../src/PostResponseParser.py' | sed -n 10P 
		cat '../test/test_data/test-4.xml' | '../src/PostResponseParser.py' | sed -n 11P 
	}
	feed() {
		# Feed したときに image_id 一覧を取得する
		local PAGE1=`cat '../test/test_data/test_feed_50.xml' | '../src/FeedResponseParser.py' | cut -f1`
		local PAGE2=`cat '../test/test_data/test_feed_50_next_dup.xml' | '../src/FeedResponseParser.py' | cut -f1`
		# 重複「20211006125842p」は1件のみ
		# 非重複「20211006125843p」等は結合される
		local ALL=`cat <(echo -e "$PAGE1") <(echo -e "$PAGE2") | sort -r | uniq`
		echo -e "$ALL"
		# ページ数を取得する
		local PAGE_NUM=`cat '../test/test_data/test_feed_50.xml' | '../src/FeedResponseParser.py' -H | head -n +1 | cut -f4`
		echo "$PAGE_NUM"
		# ページ数を指定する
#		'../src/run.sh' feed -p $PAGE_NUM
	}
	get() {
		# IMAGE_IDからIMAGE_DATETIMEを取得してgetする
		local ID=20211008165941p
		local DT=${ID/%?/}
		'../src/run.py' get $DT
	}
	post
#	feed
#	get
}
Run "$@"
