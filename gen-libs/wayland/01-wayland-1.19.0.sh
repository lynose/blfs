#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/wayland-1.19.0
 then
  rm -rf /sources/wayland-1.19.0
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download https://wayland.freedesktop.org/releases/wayland-1.19.0.tar.xz \
    /sources &&

md5sum -c ${SCRIPTPATH}/md5-wayland &&

tar xf /sources/wayland-1.19.0.tar.xz -C /sources/ &&

cd /sources/wayland-1.19.0 &&

./configure --prefix=/usr    \
            --disable-static \
            --disable-documentation  &&
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
