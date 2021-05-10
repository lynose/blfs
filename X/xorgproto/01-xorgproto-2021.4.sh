#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/xorgproto-2021.4
 then
  rm -rf /sources/xorgproto-2021.4
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download https://xorg.freedesktop.org/archive/individual/proto/xorgproto-2021.4.tar.bz2 \
    /sources &&

md5sum -c ${SCRIPTPATH}/md5-xorgproto &&

tar xf /sources/xorgproto-2021.4.tar.bz2 -C /sources/ &&

cd /sources/xorgproto-2021.4 &&

mkdir build &&
cd    build &&

meson --prefix=$XORG_PREFIX -Dlegacy=true .. &&
${log} `basename "$0"` " configured" blfs_all &&

ninja &&
${log} `basename "$0"` " built" blfs_all &&

as_root ninja install &&

as_root install -vdm 755 $XORG_PREFIX/share/doc/xorgproto-2021.4 &&
as_root install -vm 644 ../[^m]*.txt ../PM_spec $XORG_PREFIX/share/doc/xorgproto-2021.4 &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
