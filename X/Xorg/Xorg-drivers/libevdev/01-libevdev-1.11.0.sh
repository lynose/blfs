#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/libevdev-1.11.0
 then
  as_root rm -rf /sources/libevdev-1.11.0
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download https://www.freedesktop.org/software/libevdev/libevdev-1.11.0.tar.xz \
    /sources &&

md5sum -c ${SCRIPTPATH}/md5-libevdev &&

tar xf /sources/libevdev-1.11.0.tar.xz -C /sources/ &&

cd /sources/libevdev-1.11.0 &&

./configure $XORG_CONFIG &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
${log} `basename "$0"` " built" blfs_all &&

if [ ${DANGER_TEST} == true ]
 then
  make check &&
  ${log} `basename "$0"` " check succeed" blfs_all ||
  ${log} `basename "$0"` " expected check fail?" blfs_all
fi

as_root make install &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
