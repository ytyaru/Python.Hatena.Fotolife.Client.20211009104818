#!/usr/bin/env bash
set -Ceu
#---------------------------------------------------------------------------
# はてなIDと画像IDからURLを生成する。
# CreatedAt: 2021-10-11
#---------------------------------------------------------------------------
Run() {
	THIS="$(realpath "${BASH_SOURCE:-0}")"; HERE="$(dirname "$THIS")"; PARENT="$(dirname "$HERE")"; THIS_NAME="$(basename "$THIS")"; APP_ROOT="$PARENT";
	cd "$HERE"
	. id2url_lib.sh
#	. error.sh
	VERSION=0.0.1
	USERNAME=; IMAGE_ID=;
	ParseCommand() {
		Help() { eval "echo -e \"$(cat help_id2url.txt)\""; }
		while getopts u:l:h OPT; do
		case $OPT in
			h) Help; exit 0; ;;
		esac
		done
		shift $((OPTIND - 1))
		[ $# -lt 2 ] && { Help; exit 1; } || :;
		USERNAME="$1"
		IMAGE_ID="$2"
	}
	ParseCommand "$@"
	Id2Url "$USERNAME" "$IMAGE_ID"
	Id2MediumUrl "$USERNAME" "$IMAGE_ID"
	Id2SmallUrl "$USERNAME" "$IMAGE_ID"
	Id2HatenaSyntax "$USERNAME" "$IMAGE_ID"
}
Run "$@"
