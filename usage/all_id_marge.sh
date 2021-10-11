#!/usr/bin/env bash
set -Ceu
#---------------------------------------------------------------------------
# Feedから全IDを取得する。既存ファイルの最新IDを取得した時点で終了する。（古いIDは取得しない）
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
	USERNAME="$('../src/secret.py')"
	FILENAME=${ARG_FOLDER:-top_folder}
	NewestId() { # 既存ファイルから最新IDを取得する
		[ -d "$USERNAME" ] || return
		[ -f "$USERNAME/${FILENAME}.txt" ] || return
		cat "$USERNAME/${FILENAME}.txt" | head -n +1
	}
	NEWEST_ID=`NewestId`
	echo "NEWEST_ID=${NEWEST_ID}"
	NewestIdLineNo() {
		# LINE-NO:HIT-STRING
		local LINE_NO=`echo -e "$1" | grep -n "$2"`
		echo "${LINE_NO%%:*}"
	}
	BreakNewest() {
		[ -z "$NEWEST_ID" ] && return || :;
		NEWEST_ID_LINE_NO="$(NewestIdLineNo "$ALL_ID" "$NEWEST_ID")"
		[ -n "$NEWEST_ID_LINE_NO" ] && echo "${NEWEST_ID_LINE_NO}" || :;
	}
	ALL_ID=;
	CMD_PRM=;
	[ -n "$ARG_FOLDER" ] && CMD_PRM+=" -f '$ARG_FOLDER' " || :;
	XML=`eval "'$PARENT/src/run.py' feed $CMD_PRM"`
#	echo -e "$XML"
	LIST=`echo -e "$XML" | "$PARENT/src/FeedResponseParser.py" -H`
	PAGE_NUM=`echo -e "$LIST" | head -n +1 | cut -f4`
	ALL_ID+=`echo -e "$LIST" | tail -n +2 | cut -f1`
	ALL_ID+="\n"
#	echo -e "$ALL_ID" | head -c -1 | grep -c "$NEWEST_ID" 
#	echo -e "$LIST" | tail -n +2 | cut -f1
#	echo -e "$LIST" | head -n +1 >> "$USERNAME/${FILENAME}__.txt"
#	echo -e "$LIST" | tail -n +2 | cut -f1 | sort -r | uniq >> "$USERNAME/${FILENAME}__.txt"
#	echo '' >> "$USERNAME/${FILENAME}__.txt"

#	BreakNewest
#	exit 1
	BREAK_LINE_NO=`BreakNewest`
	echo "BREAK_LINE_NO=${BREAK_LINE_NO}"
#	eval "echo -e \"$LIST\" | tail -n +2 | cut -f1 | head -n +${BREAK_LINE_NO}"
	GetAllPage() {
		for page in `seq 2 $PAGE_NUM`; do
			XML=`eval "'$PARENT/src/run.py' feed $CMD_PRM -p $page"`
			LIST=`echo -e "$XML" | "$PARENT/src/FeedResponseParser.py" -H`
			ALL_ID+=`echo -e "$LIST" | tail -n +2 | cut -f1`
			ALL_ID+="\n"
			echo -e "$LIST" | tail -n +2 | cut -f1
#			echo -e "$LIST" | tail -n +2 | cut -f1 | sort -r | uniq >> "$USERNAME/${FILENAME}__.txt"
#			echo '' >> "$USERNAME/${FILENAME}__.txt"
			sleep 1
		done
	}
	mkdir -p "$USERNAME"
	[ -z "$BREAK_LINE_NO" ] && {
#		ALL_ID+=`echo -e "$LIST" | tail -n +2 | cut -f1`
#		ALL_ID+="\n"
		echo -e "$ALL_ID"
		GetAllPage 
		echo -e "$ALL_ID" | head -c -1 | sort -r | uniq >| "$USERNAME/$FILENAME.txt"
	} || {
#		ALL_ID=`eval "echo -e \"$LIST\" | tail -n +2 | cut -f1 | head -n +${BREAK_LINE_NO}"`;
		ALL_ID=`eval "echo -e \"$LIST\" | tail -n +2 | cut -f1 | head -n +$((BREAK_LINE_NO - 1))"`;
		ALL_ID+="\n"
		echo "====================="
		echo -e "$ALL_ID"
		OLD_FILE=`cat "$USERNAME/$FILENAME.txt"`
		echo -e "$ALL_ID" | head -c -1 | sort -r | uniq >| "$USERNAME/$FILENAME.txt"
		echo -e "$OLD_FILE" >> "$USERNAME/$FILENAME.txt"
	}
#	mkdir -p "$USERNAME"
#	echo -e "$ALL_ID" | head -c -1 | sort -r | uniq > "$USERNAME/$FILENAME.txt"
}
Run "$@"
