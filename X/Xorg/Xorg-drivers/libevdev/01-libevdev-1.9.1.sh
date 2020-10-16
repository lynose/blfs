#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/libevdev-1.9.1
 then
  rm -rf /sources/libevdev-1.9.1
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

wget https://www.freedesktop.org/software/libevdev/libevdev-1.9.1.tar.xz \
    --continue --directory-prefix=/sources &&

md5sum -c ${SCRIPTPATH}/md5-libevdev-1.9.1.tar.xz &&

tar xf /sources/libevdev-1.9.1.tar.xz -C /sources/ &&

cd /sources/libevdev-1.9.1 &&

./configure $XORG_CONFIG && &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
${log} `basename "$0"` " built" blfs_all &&

make install &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
