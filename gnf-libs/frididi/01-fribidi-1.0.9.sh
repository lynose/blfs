#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/fribidi-1.0.9
 then
  rm -rf /sources/fribidi-1.0.9
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download https://github.com/fribidi/fribidi/releases/download/v1.0.9/fribidi-1.0.9.tar.xz \
    /sources &&

md5sum -c ${SCRIPTPATH}/md5-fribidi &&

tar xf /sources/fribidi-1.0.9.tar.xz -C /sources/ &&

cd /sources/fribidi-1.0.9 &&

mkdir build &&
cd    build &&

meson --prefix=/usr .. &&
${log} `basename "$0"` " configured" blfs_all &&

ninja &&
${log} `basename "$0"` " built" blfs_all &&

ninja test &&
${log} `basename "$0"` " check succeed" blfs_all &&

as_root ninja install &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
