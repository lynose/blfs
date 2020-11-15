#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/wayland-protocols-1.20
 then
  rm -rf /sources/wayland-protocols-1.20
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download https://wayland.freedesktop.org/releases/wayland-protocols-1.20.tar.xz \
    /sources &&

md5sum -c ${SCRIPTPATH}/md5-wayland-protocols &&

tar xf /sources/wayland-protocols-1.20.tar.xz -C /sources/ &&

cd /sources/wayland-protocols-1.20 &&

./configure --prefix=/usr    &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
${log} `basename "$0"` " built" blfs_all &&

make check &&
${log} `basename "$0"` " check succeed" blfs_all &&

as_root make install &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
