#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/LibRaw-0.20.2
 then
  rm -rf /sources/LibRaw-0.20.2
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download http://www.libraw.org/data/LibRaw-0.20.2.tar.gz \
    /sources &&

md5sum -c ${SCRIPTPATH}/md5-LibRaw &&

tar xf /sources/LibRaw-0.20.2.tar.gz -C /sources/ &&

cd /sources/LibRaw-0.20.2 &&

autoreconf -fiv              &&
./configure --prefix=/usr    \
            --enable-jpeg    \
            --enable-jasper  \
            --enable-lcms    \
            --disable-static \
            --docdir=/usr/share/doc/libraw-0.20.2 &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
${log} `basename "$0"` " built" blfs_all &&

as_root make install &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
