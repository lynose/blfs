#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/libinput-1.16.4
 then
  rm -rf /sources/libinput-1.16.4
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download https://www.freedesktop.org/software/libinput/libinput-1.16.4.tar.xz \
    /sources &&

md5sum -c ${SCRIPTPATH}/md5-libinput &&

tar xf /sources/libinput-1.16.4.tar.xz -C /sources/ &&

cd /sources/libinput-1.16.4 &&

mkdir build &&
cd    build &&

meson --prefix=$XORG_PREFIX \
      -Dudev-dir=/lib/udev  \
      -Ddebug-gui=false     \
      -Dtests=false         \
      -Ddocumentation=false \
      -Dlibwacom=false      \
      ..                  &&
${log} `basename "$0"` " configured" blfs_all &&

ninja &&
${log} `basename "$0"` " built" blfs_all &&

as_root ninja install &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
