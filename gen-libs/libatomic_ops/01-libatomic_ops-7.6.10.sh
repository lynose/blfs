#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/libatomic_ops-7.6.10
 then
  rm -rf /sources/libatomic_ops-7.6.10
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

wget https://github.com/ivmai/libatomic_ops/releases/download/v7.6.10/libatomic_ops-7.6.10.tar.gz \
    --continue --directory-prefix=/sources &&

md5sum -c ${SCRIPTPATH}/md5-libatomic_ops &&

tar xf /sources/libatomic_ops-7.6.10.tar.gz -C /sources/ &&

cd /sources/libatomic_ops-7.6.10 &&

./configure --prefix=/usr    \
            --enable-shared  \
            --disable-static \
            --docdir=/usr/share/doc/libatomic_ops-7.6.10 &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
${log} `basename "$0"` " built" blfs_all &&

make check &&
${log} `basename "$0"` " check succeed" blfs_all &&

make install &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
