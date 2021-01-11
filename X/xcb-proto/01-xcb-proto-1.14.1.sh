#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/xcb-proto-1.14.1
 then
  rm -rf /sources/xcb-proto-1.14.1
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download https://xorg.freedesktop.org/archive/individual/proto/xcb-proto-1.14.1.tar.xz \
    /sources &&

md5sum -c ${SCRIPTPATH}/md5-xcb-proto &&

tar xf /sources/xcb-proto-1.14.1.tar.xz -C /sources/ &&

cd /sources/xcb-proto-1.14.1 &&

./configure $XORG_CONFIG &&
${log} `basename "$0"` " configured" blfs_all &&

if [ ${ENABLE_TEST} == true ]
 then
  make check &&
  ${log} `basename "$0"` " check succeed" blfs_all ||
  ${log} `basename "$0"` " expected check fail?" blfs_all
fi

as_root make install &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
