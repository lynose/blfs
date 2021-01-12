#!/bin/bash

${log} `basename "$0"` " started" blfs_all &&
SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

if test -d /sources/nghttp2-1.42.0
 then
  rm -rf /sources/nghttp2-1.42.0
fi

${log} `basename "$0"` " Downloading" blfs_all &&
check_and_download https://github.com/nghttp2/nghttp2/releases/download/v1.42.0/nghttp2-1.42.0.tar.xz \
/sources &&

md5sum -c ${SCRIPTPATH}/md5-nghttp2 &&

tar xf /sources/nghttp2-1.42.0.tar.xz -C /sources/ &&

cd /sources/nghttp2-1.42.0 &&

./configure --prefix=/usr     \
            --disable-static  \
            --docdir=/usr/share/doc/nghttp2-1.42.0 &&
${log} `basename "$0"` " configured" blfs_all &&

make && 
${log} `basename "$0"` " build" blfs_all &&

as_root make install &&
${log} `basename "$0"` " installed" blfs_all &&

${log} `basename "$0"` " finished" blfs_all
