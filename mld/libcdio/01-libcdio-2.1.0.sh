#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/libcdio-2.1.0
 then
  rm -rf /sources/libcdio-2.1.0
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download https://ftp.gnu.org/gnu/libcdio/libcdio-2.1.0.tar.bz2 \
    /sources &&
check_and_download https://ftp.gnu.org/gnu/libcdio/libcdio-paranoia-10.2+2.0.1.tar.bz2 \
    /sources &&
md5sum -c ${SCRIPTPATH}/md5-libcdio &&

tar xf /sources/libcdio-2.1.0.tar.bz2 -C /sources/ &&

cd /sources/libcdio-2.1.0 &&

./configure --prefix=/usr --disable-static &&
${log} `basename "$0"` " configured libcdio" blfs_all &&

make &&
${log} `basename "$0"` " built libcdio" blfs_all &&

make check &&
${log} `basename "$0"` " check succeed libcdio" blfs_all &&

as_root make install &&
${log} `basename "$0"` " installed libcdio" blfs_all &&


tar -xf ../libcdio-paranoia-10.2+2.0.1.tar.bz2 &&
cd libcdio-paranoia-10.2+2.0.1 &&

./configure --prefix=/usr --disable-static &&
${log} `basename "$0"` " configured libcdio-paranoia" blfs_all &&

make &&
${log} `basename "$0"` " built libcdio-paranoia" blfs_all &&

make check &&
${log} `basename "$0"` " check succeed libcdio-paranoia" blfs_all &&

as_root make install &&
${log} `basename "$0"` " installed libcdio-paranoia" blfs_all &&


${log} `basename "$0"` " finished" blfs_all 
