#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/xcb-util-image-0.4.0
 then
  rm -rf /sources/xcb-util-image-0.4.0
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download https://xcb.freedesktop.org/dist/xcb-util-image-0.4.0.tar.bz2 \
    /sources &&

md5sum -c ${SCRIPTPATH}/md5-xcb-util-image &&

tar xf /sources/xcb-util-image-0.4.0.tar.bz2 -C /sources/ &&

cd /sources/xcb-util-image-0.4.0 &&

./configure $XORG_CONFIG &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
${log} `basename "$0"` " built" blfs_all &&

if [ ${ENABLE_TEST} == true ]
 then
  LD_LIBRARY_PATH=$XORG_PREFIX/lib make check &&
  ${log} `basename "$0"` " check succeed" blfs_all ||
  ${log} `basename "$0"` " expected check fail?" blfs_all
fi



as_root make install &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
