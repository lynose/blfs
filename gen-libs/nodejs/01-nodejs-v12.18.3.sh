#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/node-v12.18.3
 then
  rm -rf /sources/node-v12.18.3
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download https://nodejs.org/dist/v12.18.3/node-v12.18.3.tar.xz \
    /sources &&

md5sum -c ${SCRIPTPATH}/md5-nodejs &&

tar xf /sources/node-v12.18.3.tar.xz -C /sources/ &&

cd /sources/node-v12.18.3 &&

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

make test-only &&
${log} `basename "$0"` " check succeed" blfs_all &&

as_root make install &&
ln -sf node /usr/share/doc/node-12.18.3 &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
