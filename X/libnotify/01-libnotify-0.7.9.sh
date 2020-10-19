#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/libnotify-0.7.9
 then
  rm -rf /sources/libnotify-0.7.9
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

wget http://ftp.gnome.org/pub/gnome/sources/libnotify/0.7/libnotify-0.7.9.tar.xz \
    --continue --directory-prefix=/sources &&

md5sum -c ${SCRIPTPATH}/md5-libnotify &&

tar xf /sources/libnotify-0.7.9.tar.xz -C /sources/ &&

cd /sources/libnotify-0.7.9 &&

mkdir build &&
cd    build &&

meson --prefix=/usr -Dman=false ..  &&
${log} `basename "$0"` " configured" blfs_all &&

ninja &&
${log} `basename "$0"` " built" blfs_all &&

ninja install &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
