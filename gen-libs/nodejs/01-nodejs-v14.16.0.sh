#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/node-v14.16.0
 then
  as_root rm -rf /sources/node-v14.16.0
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download https://nodejs.org/dist/v14.16.0/node-v14.16.0.tar.xz \
    /sources &&

md5sum -c ${SCRIPTPATH}/md5-nodejs &&

tar xf /sources/node-v14.16.0.tar.xz -C /sources/ &&

cd /sources/node-v14.16.0 &&

./configure --prefix=/usr                  \
            --shared-cares                 \
            --shared-libuv                 \
            --shared-openssl               \
            --shared-nghttp2               \
            --shared-zlib                  \
            --with-intl=system-icu    &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
${log} `basename "$0"` " built" blfs_all &&

if [ ${ENABLE_TEST} == true ]
 then
  make test-only &&
  ${log} `basename "$0"` " check succeed" blfs_all ||
  ${log} `basename "$0"` " expected check fail?" blfs_all
fi

as_root make install &&
as_root ln -sf node /usr/share/doc/node-14.16.0 &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
