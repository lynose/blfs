#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/xf86-input-libinput-1.1.0
 then
  rm -rf /sources/xf86-input-libinput-1.1.0
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download https://www.x.org/pub/individual/driver/xf86-input-libinput-1.1.0.tar.bz2 \
    /sources &&

md5sum -c ${SCRIPTPATH}/md5-xf86-input-libinput &&

tar xf /sources/xf86-input-libinput-1.1.0.tar.bz2 -C /sources/ &&

cd /sources/xf86-input-libinput-1.1.0 &&

./configure $XORG_CONFIG &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
${log} `basename "$0"` " built" blfs_all &&

if [ ${ENABLE_TEST} == true ]
 then
  make check &&
  ${log} `basename "$0"` " check succeed" blfs_all ||
  ${log} `basename "$0"` " expected check fail?" blfs_all
fi

as_root make install &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
