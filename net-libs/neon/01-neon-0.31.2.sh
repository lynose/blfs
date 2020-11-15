#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/neon-0.31.2
 then
  rm -rf /sources/neon-0.31.2
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download https://notroj.github.io/neon/neon-0.31.2.tar.gz \
    /sources &&

md5sum -c ${SCRIPTPATH}/md5-neon &&

tar xf /sources/neon-0.31.2.tar.gz -C /sources/ &&

cd /sources/neon-0.31.2 &&

./configure --prefix=/usr    \
            --with-ssl       \
            --enable-shared  \
            --disable-static &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
${log} `basename "$0"` " built" blfs_all &&

make check &&
${log} `basename "$0"` " check succeed" blfs_all &&

as_root make install &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
