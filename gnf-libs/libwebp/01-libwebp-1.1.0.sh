#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/libwebp-1.1.0
 then
  rm -rf /sources/libwebp-1.1.0
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download http://downloads.webmproject.org/releases/webp/libwebp-1.1.0.tar.gz \
    /sources &&

md5sum -c ${SCRIPTPATH}/md5-libwebp &&

tar xf /sources/libwebp-1.1.0.tar.gz -C /sources/ &&

cd /sources/libwebp-1.1.0 &&

./configure --prefix=/usr           \
            --enable-libwebpmux     \
            --enable-libwebpdemux   \
            --enable-libwebpdecoder \
            --enable-libwebpextras  \
            --enable-swap-16bit-csp \
            --disable-static &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
${log} `basename "$0"` " built" blfs_all &&

as_root make install &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
