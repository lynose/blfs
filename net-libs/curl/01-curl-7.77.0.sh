#!/bin/bash

${log} `basename "$0"` " started" blfs_all &&

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

if test -d /sources/curl-7.77.0
 then
  as_root rm -rf /sources/curl-7.77.0
fi

${log} `basename "$0"` " Downloading" blfs_all &&
check_and_download https://curl.haxx.se/download/curl-7.77.0.tar.xz \
/sources &&

md5sum -c ${SCRIPTPATH}/md5-curl &&

tar xf /sources/curl-7.77.0.tar.xz -C /sources/ &&

cd /sources/curl-7.77.0 &&

grep -rl '#!.*python$' | xargs sed -i '1s/python/&3/' &&

patch -Np1 -i ../curl-7.77.0-function_naming-1.patch &&

./configure --prefix=/usr                           \
            --disable-static                        \
            --with-openssl                          \
            --enable-threaded-resolver              \
            --with-ca-path=/etc/ssl/certs &&
${log} `basename "$0"` " configured" blfs_all &&

make && 
${log} `basename "$0"` " build" blfs_all &&

if [ ${ENABLE_TEST} == true ]
 then
  make test &&
  ${log} `basename "$0"` " check succeed" blfs_all ||
  ${log} `basename "$0"` " expected check fail?" blfs_all
fi

as_root make install &&

as_root rm -rf docs/examples/.deps &&

find docs \( -name Makefile\* -o -name \*.1 -o -name \*.3 \) -exec as_root rm {} \; &&

as_root install -v -d -m755 /usr/share/doc/curl-7.77.0 &&
as_root cp -v -R docs/*     /usr/share/doc/curl-7.77.0 &&
${log} `basename "$0"` " installed" blfs_all &&

${log} `basename "$0"` " finished" blfs_all
