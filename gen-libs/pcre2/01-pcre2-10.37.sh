#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/pcre2-10.37
 then
  as_root rm -rf /sources/pcre2-10.37
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download https://ftp.pcre.org/pub/pcre/pcre2-10.37.tar.bz2 \
    /sources &&


md5sum -c ${SCRIPTPATH}/md5-pcre2 &&

tar xf /sources/pcre2-10.37.tar.bz2 -C /sources/ &&

cd /sources/pcre2-10.37 &&

./configure --prefix=/usr                       \
            --docdir=/usr/share/doc/pcre2-10.37 \
            --enable-unicode                    \
            --enable-jit                        \
            --enable-pcre2-16                   \
            --enable-pcre2-32                   \
            --enable-pcre2grep-libz             \
            --enable-pcre2grep-libbz2           \
            --enable-pcre2test-libreadline      \
            --disable-static   &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
${log} `basename "$0"` " built" blfs_all &&

if [ ${ENABLE_TEST} == true ]
 then
  make check &&
  ${log} `basename "$0"` " check succeed" blfs_all ||
  ${log} `basename "$0"` " expected check fail?" blfs_all
fi

as_root make install &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 