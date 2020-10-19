#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/libdvdread-6.1.1
 then
  rm -rf /sources/libdvdread-6.1.1
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

wget https://get.videolan.org/libdvdread/6.1.1/libdvdread-6.1.1.tar.bz2 \
    --continue --directory-prefix=/sources &&

md5sum -c ${SCRIPTPATH}/md5-libdvdread &&

tar xf /sources/libdvdread-6.1.1.tar.bz2 -C /sources/ &&

cd /sources/libdvdread-6.1.1 &&

./configure --prefix=/usr    \
            --disable-static \
            --docdir=/usr/share/doc/libdvdread-6.1.1 &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
${log} `basename "$0"` " built" blfs_all &&

make install &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
