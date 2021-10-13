#!/usr/bin/env bash
set -Ceu
#---------------------------------------------------------------------------
# 画像ID一覧ファイルから画像ファイルを全件取得する。
# CreatedAt: 2021-10-11
#---------------------------------------------------------------------------
Run() {
	THIS="$(realpath "${BASH_SOURCE:-0}")"; HERE="$(dirname "$THIS")"; PARENT="$(dirname "$HERE")"; THIS_NAME="$(basename "$THIS")"; APP_ROOT="$PARENT";
	cd "$HERE"
	VERSION=0.0.1
	PATH_IMG_URL=;
	ParseCommand() {
		echo '**************:'
		Help() { eval "echo -e \"$(cat help_all_image_get.txt)\""; }
		echo '**************:'
		while getopts u:l:h OPT; do
		case $OPT in
			h) Help; exit 0; ;;
		esac
		done
		shift $((OPTIND - 1))
		[ $# -lt 1 ] && { Help; exit 1; } || :;
		PATH_IMG_URL="$(realpath "$1")"
		USERNAME="$(basename "$(dirname "$PATH_IMG_URL")")"
	}
	ParseCommand "$@"

	ALL_LINE=`cat "$PATH_IMG_URL" | tail -n +2 | cut -f1`
	echo -e "$ALL_LINE" | while read LINE; do
		wget "$LINE"
		sleep 2
	done
}
Run "$@"
