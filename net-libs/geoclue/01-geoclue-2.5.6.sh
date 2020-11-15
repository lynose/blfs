#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/geoclue-2.5.6
 then
  rm -rf /sources/geoclue-2.5.6
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download https://gitlab.freedesktop.org/geoclue/geoclue/-/archive/2.5.6/geoclue-2.5.6.tar.bz2 \
    /sources &&

md5sum -c ${SCRIPTPATH}/md5-geoclue &&

tar xf /sources/geoclue-2.5.6.tar.bz2 -C /sources/ &&

cd /sources/geoclue-2.5.6 &&

mkdir build &&
cd    build &&

meson --prefix=/usr .. &&
${log} `basename "$0"` " configured" blfs_all &&

ninja &&
${log} `basename "$0"` " built" blfs_all &&

as_root ninja install &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
