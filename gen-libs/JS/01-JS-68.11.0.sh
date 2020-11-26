#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/firefox-68.11.0
 then
  as_root rm -rf /sources/firefox-68.11.0
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download https://archive.mozilla.org/pub/firefox/releases/68.11.0esr/source/firefox-68.11.0esr.source.tar.xz \
    /sources &&

md5sum -c ${SCRIPTPATH}/md5-JS &&

as_root tar xf /sources/firefox-68.11.0esr.source.tar.xz -C /sources/ &&
as_root chown -R $USER:users /sources/firefox-68.11.0 &&

cd /sources/firefox-68.11.0 &&

sed '21,+4d' -i js/moz.configure &&

mkdir obj &&
cd    obj &&

CC=gcc CXX=g++ LLVM_OBJDUMP=/bin/false       \
../js/src/configure --prefix=/usr            \
                    --with-intl-api          \
                    --with-system-zlib       \
                    --with-system-icu        \
                    --disable-jemalloc       \
                    --disable-debug-symbols  \
                    --enable-readline        \
                    --enable-unaligned-private-values &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
${log} `basename "$0"` " built" blfs_all &&

as_root make install &&
as_root rm -v /usr/lib/libjs_static.ajs &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
