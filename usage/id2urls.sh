#!/usr/bin/env bash
set -Ceu
#---------------------------------------------------------------------------
# 画像ID一覧ファイルからURL一覧ファイルを生成する。
# CreatedAt: 2021-10-11
#---------------------------------------------------------------------------
Run() {
	THIS="$(realpath "${BASH_SOURCE:-0}")"; HERE="$(dirname "$THIS")"; PARENT="$(dirname "$HERE")"; THIS_NAME="$(basename "$THIS")"; APP_ROOT="$PARENT";
	cd "$HERE"
	. id2url_lib.sh
	VERSION=0.0.1
	PATH_IMG_ID=;
	ParseCommand() {
		Help() { eval "echo -e \"$(cat help_id2urls.txt)\""; }
		while getopts u:l:h OPT; do
		case $OPT in
			h) Help; exit 0; ;;
		esac
		done
		shift $((OPTIND - 1))
		[ $# -lt 1 ] && { Help; exit 1; } || :;
		PATH_IMG_ID="$(realpath "$1")"
		USERNAME="$(basename "$(dirname "$PATH_IMG_ID")")"
	}
	ParseCommand "$@"

	ALL_LINE=;
	ALL_LINE+="URL\tMediumURL\tSmallURL\tHatenaSyntax\n"
#	echo -e 'URL\tMediumURL\tSmallURL\tHatenaSyntax'
	while read LINE; do
		ALL_LINE+="$(Id2Url "$USERNAME" "$LINE")\t"
		ALL_LINE+="$(Id2MediumUrl "$USERNAME" "$LINE")\t"
		ALL_LINE+="$(Id2SmallUrl "$USERNAME" "$LINE")\t"
		ALL_LINE+="$(Id2HatenaSyntax "$USERNAME" "$LINE")\n"
#		echo -en "$(Id2Url "$USERNAME" "$LINE")"
#		echo -en "\t"
#		echo -en "$(Id2MediumUrl "$USERNAME" "$LINE")"
#		echo -en "\t"
#		echo -en "$(Id2SmallUrl "$USERNAME" "$LINE")"
#		echo -en "\t"
#		echo -en "$(Id2HatenaSyntax "$USERNAME" "$LINE")"
#		echo ''
	done < "$PATH_IMG_ID"
	FOLDER="$(basename "$PATH_IMG_ID")"
	echo -e "$ALL_LINE" | sed '$d' >| "$(dirname "$PATH_IMG_ID")/${FOLDER%.*}.url.tsv"
#	echo -e "$ALL_LINE" >| "$(dirname "$PATH_IMG_ID")/${FOLDER%.*}.url.tsv"
#	echo -e "$ALL_LINE" | tail -n +2 | sed '$d' >| "$(dirname "$PATH_IMG_ID")/${FOLDER%.*}.url.tsv"
#	echo -e "$ALL_LINE" | tail -n +2 | sed '$d' | cut -f1 >| "$(dirname "$PATH_IMG_ID")/${FOLDER%.*}.url.tsv"
}
Run "$@"
