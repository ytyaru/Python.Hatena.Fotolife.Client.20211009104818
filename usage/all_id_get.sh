#!/usr/bin/env bash
set -Ceu
#---------------------------------------------------------------------------
# Feedから全IDを取得する。
# CreatedAt: 2021-10-11
#---------------------------------------------------------------------------
Run() {
	THIS="$(realpath "${BASH_SOURCE:-0}")"; HERE="$(dirname "$THIS")"; PARENT="$(dirname "$HERE")"; THIS_NAME="$(basename "$THIS")"; APP_ROOT="$PARENT";
	cd "$HERE"
	ARG_FOLDER=; ARG_NEWER_ID=; ARG_OLDER_ID=;
	ParseCommand() {
		while getopts f:l:h OPT; do
		case $OPT in
			f) ARG_FOLDER="$OPTARG";;
			n) ARG_NEWER_ID="$OPTARG";;
			o) ARG_OLDER_ID="$OPTARG";;
			h) exit 1;;
		esac
		done
		shift $((OPTIND - 1))
	}
	ParseCommand "$@"
	ALL_ID=;
	CMD_PRM=;
	[ -n "$ARG_FOLDER" ] && CMD_PRM+=" -f '$ARG_FOLDER' " || :;
	XML=`eval "'$PARENT/src/run.sh' feed $CMD_PRM"`
	LIST=`echo -e "$XML" | "$PARENT/src/FeedResponseParser.py" -H`
	PAGE_NUM=`echo -e "$LIST" | head -n +1 | cut -f4`
	ALL_ID+=`echo -e "$LIST" | tail -n +2 | cut -f1`
	for page in `seq 2 $PAGE_NUM`; do
		XML=`eval "'$PARENT/src/run.sh' feed $CMD_PRM -p $page"`
		LIST=`echo -e "$XML" | "$PARENT/src/FeedResponseParser.py" -H`
		ALL_ID+=`echo -e "$LIST" | tail -n +2 | cut -f1`
		sleep 1
	done
	echo -e "$ALL_ID" | sort -r | uniq > all_id.txt
	# NEWER_IDより新しいものがない
	# NEWER_IDより新しいものがある
	# OLDER_IDより古いものがない
	# OLDER_IDより古いものがある
	# リスト中にある最新はNEWER_IDより新しい
	# リスト中にある最古はNEWER_IDより新しい
	# リスト中にある最新はOLDER_IDより新しい
	# リスト中にある最古はOLDER_IDより新しい
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
#	post
	feed
#	get
}
Run "$@"
