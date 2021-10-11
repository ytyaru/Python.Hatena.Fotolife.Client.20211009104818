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
	USERNAME="$('../src/secret.py')"
	FILENAME=${ARG_FOLDER:-top_folder}
	ALL_ID=;
	CMD_PRM=;
	[ -n "$ARG_FOLDER" ] && CMD_PRM+=" -f '$ARG_FOLDER' " || :;
	XML=`eval "'$PARENT/src/run.py' feed $CMD_PRM"`
	echo -e "$XML"
	LIST=`echo -e "$XML" | "$PARENT/src/FeedResponseParser.py" -H`
	PAGE_NUM=`echo -e "$LIST" | head -n +1 | cut -f4`
	ALL_ID+=`echo -e "$LIST" | tail -n +2 | cut -f1`
	ALL_ID+="\n"
	echo -e "$LIST"
#	echo -e "$LIST" | head -n +1 >> "$USERNAME/${FILENAME}__.txt"
#	echo -e "$LIST" | tail -n +2 | cut -f1 | sort -r | uniq >> "$USERNAME/${FILENAME}__.txt"
#	echo '' >> "$USERNAME/${FILENAME}__.txt"
	for page in `seq 2 $PAGE_NUM`; do
		XML=`eval "'$PARENT/src/run.py' feed $CMD_PRM -p $page"`
		LIST=`echo -e "$XML" | "$PARENT/src/FeedResponseParser.py" -H`
		ALL_ID+=`echo -e "$LIST" | tail -n +2 | cut -f1`
		ALL_ID+="\n"
		echo -e "$LIST" | tail -n +2 | cut -f1
#		echo -e "$LIST" | tail -n +2 | cut -f1 | sort -r | uniq >> "$USERNAME/${FILENAME}__.txt"
#		echo '' >> "$USERNAME/${FILENAME}__.txt"
		sleep 1
	done
	mkdir -p "$USERNAME"
	echo -e "$ALL_ID" | head -c -1 | sort -r | uniq > "$USERNAME/$FILENAME.txt"
}
Run "$@"
