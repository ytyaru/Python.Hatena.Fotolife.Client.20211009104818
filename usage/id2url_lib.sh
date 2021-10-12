#!/usr/bin/env bash
set -Ceu
#---------------------------------------------------------------------------
# ユーザ名と画像IDからURLを生成する処理の心臓部分。
# CreatedAt: 2021-10-11
#---------------------------------------------------------------------------
THIS="$(realpath "${BASH_SOURCE:-0}")"; HERE="$(dirname "$THIS")"; PARENT="$(dirname "$HERE")"; THIS_NAME="$(basename "$THIS")"; APP_ROOT="$PARENT";
cd "$HERE"
. error.sh
Id2Ext() {
	case ${1: -1} in
	p) echo 'png';;
	j) echo 'jpg';;
	g) echo 'gif';;
	f) echo 'jpg';;# かつては動画の Flash 形式だったがサービス終了して jpg にされた
	*) Error "未知の拡張子です。p,j,g,fのいずれかにしてください。:${1: -1}"; exit 1;;
	esac 
}
Id2Type() {
	case ${1: -1} in
	p|j|g) echo 'image';;
	f) echo 'movie';;
	*) Error "未知の拡張子です。p,j,g,fのいずれかにしてください。:${1: -1}"; exit 2;;
	esac 
}
# $1:username(hatena_id), $2:yyyyMMddHHmmss[pjgf]
Id2Url() { echo "https://cdn-ak.f.st-hatena.com/images/fotolife/${1:0:1}/$1/${2:0:-7}/${2:0:-1}.$(Id2Ext $2)"; }
Id2SmallUrl() { echo "https://cdn-ak.f.st-hatena.com/images/fotolife/${1:0:1}/$1/${2:0:-7}/${2:0:-1}_m.jpg"; }
Id2MediumUrl() { echo "https://cdn-ak.f.st-hatena.com/images/fotolife/${1:0:1}/$1/${2:0:-7}/${2:0:-1}_120.jpg"; }
Id2HatenaSyntax() { echo "f:id:$1:$2:$(Id2Type $2)"; }

