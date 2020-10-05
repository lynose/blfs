#!/bin/bash

${log} `basename "$0"` " started" blfs_all &&

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

if test -d /sources/curl-7.71.1
 then
  rm -rf /sources/curl-7.71.1
fi

${log} `basename "$0"` " Downloading" blfs_all &&
wget https://curl.haxx.se/download/curl-7.71.1.tar.xz \
--continue --directory-prefix=/sources &&

wget http://www.linuxfromscratch.org/patches/blfs/10.0/curl-7.71.1-security_fixes-1.patch \
--continue --directory-prefix=/sources &&

md5sum -c ${SCRIPTPATH}/md5-curl &&

tar xf /sources/curl-7.71.1.tar.xz -C /sources/ &&

cd /sources/curl-7.71.1 &&

patch -Np1 -i ../curl-7.71.1-security_fixes-1.patch &&

./configure --prefix=/usr                           \
            --disable-static                        \
            --enable-threaded-resolver              \
            --with-ca-path=/etc/ssl/certs &&
${log} `basename "$0"` " configured" blfs_all &&

make && 
${log} `basename "$0"` " build" blfs_all &&

make test &&
${log} `basename "$0"` " unexpected check succeed" blfs_all
${log} `basename "$0"` " expected check fail?" blfs_all &&

make install &&

rm -rf docs/examples/.deps &&

find docs \( -name Makefile\* -o -name \*.1 -o -name \*.3 \) -exec rm {} \; &&

install -v -d -m755 /usr/share/doc/curl-7.71.1 &&
cp -v -R docs/*     /usr/share/doc/curl-7.71.1 &&
${log} `basename "$0"` " installed" blfs_all &&

${log} `basename "$0"` " finished" blfs_all
