#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/xcb-util-wm-0.4.1
 then
  rm -rf /sources/xcb-util-wm-0.4.1
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download https://xcb.freedesktop.org/dist/xcb-util-wm-0.4.1.tar.bz2 \
    /sources &&

md5sum -c ${SCRIPTPATH}/md5-xcb-util-wm &&

tar xf /sources/xcb-util-wm-0.4.1.tar.bz2 -C /sources/ &&

cd /sources/xcb-util-wm-0.4.1 &&

./configure $XORG_CONFIG &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
${log} `basename "$0"` " built" blfs_all &&

as_root make install &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
