#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/firefox-78.6.1
 then
  rm -rf /sources/firefox-78.6.1
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download https://archive.mozilla.org/pub/firefox/releases/78.6.1esr/source/firefox-78.6.1esr.source.tar.xz \
    /sources &&

md5sum -c ${SCRIPTPATH}/md5-JS &&

# Will return a non-zero value, but can be continued
tar xf /sources/firefox-78.6.1esr.source.tar.xz -C /sources/

cd /sources/firefox-78.6.1 &&

mkdir obj &&
cd    obj &&

CC=gcc CXX=g++ \
../js/src/configure --prefix=/usr            \
                    --with-intl-api          \
                    --with-system-zlib       \
                    --with-system-icu        \
                    --disable-jemalloc       \
                    --disable-debug-symbols  \
                    --enable-readline        &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
${log} `basename "$0"` " built" blfs_all &&

if [ ${ENABLE_TEST} == true ]
 then
  make -C js/src check-jstests JSTESTS_EXTRA_ARGS="--timeout 300 --wpt=disabled" &&
  ${log} `basename "$0"` " check succeed" blfs_all ||
  ${log} `basename "$0"` " expected check fail?" blfs_all
  make -C js/src check-jit-test JITTEST_EXTRA_ARGS="--timeout 300" &&
  ${log} `basename "$0"` " JIT check succeed" blfs_all ||
  ${log} `basename "$0"` " JIT expected check fail?" blfs_all
fi

as_root make install &&
as_root rm -v /usr/lib/libjs_static.ajs &&
as_root sed -i '/@NSPR_CFLAGS@/d' /usr/bin/js78-config
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
