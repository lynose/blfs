#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/libxcb-1.14
 then
  rm -rf /sources/libxcb-1.14
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

wget https://xorg.freedesktop.org/archive/individual/lib/libxcb-1.14.tar.xz \
    --continue --directory-prefix=/sources &&

md5sum -c ${SCRIPTPATH}/md5-libxcb &&

tar xf /sources/libxcb-1.14.tar.xz -C /sources/ &&

cd /sources/libxcb-1.14 &&



CFLAGS=-Wno-error=format-extra-args ./configure $XORG_CONFIG      \
            --docdir='${datadir}'/doc/libxcb-1.14 &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
${log} `basename "$0"` " built" blfs_all &&

make check &&
${log} `basename "$0"` " check succeed" blfs_all &&

make install &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
