#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/xorg-server-1.20.8
 then
  rm -rf /sources/xorg-server-1.20.8
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download https://www.x.org/pub/individual/xserver/xorg-server-1.20.8.tar.bz2 \
    /sources &&

md5sum -c ${SCRIPTPATH}/md5-xorg-server &&

tar xf /sources/xorg-server-1.20.8.tar.bz2 -C /sources/ &&

cd /sources/xorg-server-1.20.8 &&

sed -i 's/malloc(pScreen/calloc(1, pScreen/' dix/pixmap.c &&

./configure $XORG_CONFIG            \
            --enable-glamor         \
            --enable-suid-wrapper   \
            --with-xkb-output=/var/lib/xkb &&
${log} `basename "$0"` " configured" blfs_all &&


make &&
${log} `basename "$0"` " built" blfs_all &&

as_root ldconfig &&
make check &&
${log} `basename "$0"` " check succeed" blfs_all &&

as_root make install &&
as_root mkdir -pv /etc/X11/xorg.conf.d &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
