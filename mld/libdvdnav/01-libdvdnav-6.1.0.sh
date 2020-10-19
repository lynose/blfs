#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/libdvdnav-6.1.0
 then
  rm -rf /sources/libdvdnav-6.1.0
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

wget https://get.videolan.org/libdvdnav/6.1.0/libdvdnav-6.1.0.tar.bz2 \
    --continue --directory-prefix=/sources &&

md5sum -c ${SCRIPTPATH}/md5-libdvdnav &&

tar xf /sources/libdvdnav-6.1.0.tar.bz2 -C /sources/ &&

cd /sources/libdvdnav-6.1.0 &&

./configure --prefix=/usr    \
            --disable-static \
            --docdir=/usr/share/doc/libdvdnav-6.1.0 &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
${log} `basename "$0"` " built" blfs_all &&

make install &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
