#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/glu-9.0.2
 then
  rm -rf /sources/glu-9.0.2
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download ftp://ftp.freedesktop.org/pub/mesa/glu/glu-9.0.2.tar.xz \
    /sources &&

md5sum -c ${SCRIPTPATH}/md5-glu &&

tar xf /sources/glu-9.0.2.tar.xz -C /sources/ &&

cd /sources/glu-9.0.2 &&

mkdir build &&
cd    build &&

meson --prefix=$XORG_PREFIX -Dgl_provider=gl --buildtype=release .. &&
${log} `basename "$0"` " configured" blfs_all &&

ninja &&
${log} `basename "$0"` " built" blfs_all &&

as_root ninja install &&
as_root rm -v /usr/lib/libGLU.a &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
