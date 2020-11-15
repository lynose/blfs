#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/Noto-fonts
 then
  rm -rf /sources/Noto-fonts
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

mkdir /sources/Noto-fonts &&

check_and_download https://noto-website-2.storage.googleapis.com/pkgs/Noto-unhinted.zip \
    /sources/Noto-fonts &&
cd /sources/Noto-fonts &&

unzip Noto-unhinted.zip &&

as_root install -v -d -m755 /usr/share/fonts/Noto &&
as_root install -v -m644 *.ttf /usr/share/fonts/Noto &&
fc-cache -v /usr/share/fonts/Noto &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
