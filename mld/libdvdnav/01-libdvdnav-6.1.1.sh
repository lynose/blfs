#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/libdvdnav-6.1.1
 then
  rm -rf /sources/libdvdnav-6.1.1
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download https://get.videolan.org/libdvdnav/6.1.1/libdvdnav-6.1.1.tar.bz2 \
    /sources &&

md5sum -c ${SCRIPTPATH}/md5-libdvdnav &&

tar xf /sources/libdvdnav-6.1.1.tar.bz2 -C /sources/ &&

cd /sources/libdvdnav-6.1.1 &&

./configure --prefix=/usr    \
            --disable-static \
            --docdir=/usr/share/doc/libdvdnav-6.1.1 &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
${log} `basename "$0"` " built" blfs_all &&

as_root make install &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
