#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/xcb-util-cursor-0.1.3
 then
  rm -rf /sources/xcb-util-cursor-0.1.3
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

wget https://xcb.freedesktop.org/dist/xcb-util-cursor-0.1.3.tar.bz2 \
    --continue --directory-prefix=/sources &&

md5sum -c ${SCRIPTPATH}/md5-xcb-util-cursor &&

tar xf /sources/xcb-util-cursor-0.1.3.tar.bz2 -C /sources/ &&

cd /sources/xcb-util-cursor-0.1.3 &&

./configure $XORG_CONFIG &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
${log} `basename "$0"` " built" blfs_all &&

make install &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
