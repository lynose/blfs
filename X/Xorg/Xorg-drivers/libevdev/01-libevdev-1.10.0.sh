#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/libevdev-1.10.0
 then
  rm -rf /sources/libevdev-1.10.0
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download https://www.freedesktop.org/software/libevdev/libevdev-1.10.0.tar.xz \
    /sources &&

md5sum -c ${SCRIPTPATH}/md5-libevdev &&

tar xf /sources/libevdev-1.10.0.tar.xz -C /sources/ &&

cd /sources/libevdev-1.10.0 &&

./configure $XORG_CONFIG &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
${log} `basename "$0"` " built" blfs_all &&

as_root make install &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
