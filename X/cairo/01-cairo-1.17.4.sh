#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/cairo-1.17.4
 then
  rm -rf /sources/cairo-1.17.4
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download https://www.cairographics.org/snapshots/cairo-1.17.4.tar.xz \
    /sources &&

md5sum -c ${SCRIPTPATH}/md5-cairo &&

tar xf /sources/cairo-1.17.4.tar.xz -C /sources/ &&

cd /sources/cairo-1.17.4 &&

autoreconf -fv             &&
./configure --prefix=/usr    \
            --disable-static \
            --enable-gtk-doc \
            --enable-tee &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
${log} `basename "$0"` " built" blfs_all &&

as_root make install &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
