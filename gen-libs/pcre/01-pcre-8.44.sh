#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/pcre-8.44
 then
  rm -rf /sources/pcre-8.44
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`
if [ ! -f /sources/pcre-8.44.tar.bz2 ] 
 then
  wget https://ftp.pcre.org/pub/pcre/pcre-8.44.tar.bz2 \
    --continue --directory-prefix=/sources
fi

md5sum -c ${SCRIPTPATH}/md5-pcre &&

tar xf /sources/pcre-8.44.tar.bz2 -C /sources/ &&

cd /sources/pcre-8.44 &&

./configure --prefix=/usr                     \
            --docdir=/usr/share/doc/pcre-8.44 \
            --enable-unicode-properties       \
            --enable-pcre16                   \
            --enable-pcre32                   \
            --enable-pcregrep-libz            \
            --enable-pcregrep-libbz2          \
            --enable-pcretest-libreadline     \
            --disable-static   &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
${log} `basename "$0"` " built" blfs_all &&

make check &&
${log} `basename "$0"` " check succeed" blfs_all &&

make install                     &&
mv -v /usr/lib/libpcre.so.* /lib &&
ln -sfv ../../lib/$(readlink /usr/lib/libpcre.so) /usr/lib/libpcre.so &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
