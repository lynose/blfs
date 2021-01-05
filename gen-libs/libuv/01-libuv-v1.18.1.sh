#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/libuv-v1.38.1
 then
  rm -rf /sources/libuv-v1.38.1
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download https://dist.libuv.org/dist/v1.38.1/libuv-v1.38.1.tar.gz \
    /sources &&

md5sum -c ${SCRIPTPATH}/md5-libuv &&

tar xf /sources/libuv-v1.38.1.tar.gz -C /sources/ &&

cd /sources/libuv-v1.38.1 &&

sh autogen.sh                              &&
./configure --prefix=/usr --disable-static &&
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
