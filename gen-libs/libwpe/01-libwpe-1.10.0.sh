#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/libwpe-1.10.0
 then
  as_root rm -rf /sources/libwpe-1.10.0
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download http://wpewebkit.org/releases/libwpe-1.10.0.tar.xz \
        /sources &&


md5sum -c ${SCRIPTPATH}/md5-libwpe &&

tar xf /sources/libwpe-1.10.0.tar.xz -C /sources/ &&

cd /sources/libwpe-1.10.0 &&

mkdir build &&
cd    build &&

meson --prefix=/usr --buildtype=release .. &&
${log} `basename "$0"` " configured" blfs_all &&

ninja &&
${log} `basename "$0"` " built" blfs_all &&

as_root ninja install &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
