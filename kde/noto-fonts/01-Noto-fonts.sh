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

wget https://noto-website-2.storage.googleapis.com/pkgs/Noto-unhinted.zip \
    --continue --directory-prefix=/sources/Noto-fonts &&
cd /sources/Noto-fonts &&

unzip Noto-unhinted.zip &&

install -v -d -m755 /usr/share/fonts/Noto &&
install -v -m644 *.ttf /usr/share/fonts/Noto &&
fc-cache -v /usr/share/fonts/Noto &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
