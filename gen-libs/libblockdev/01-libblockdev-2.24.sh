#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/libblockdev-2.24
 then
  rm -rf /sources/libblockdev-2.24
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

wget https://github.com/storaged-project/libblockdev/releases/download/2.24-1/libblockdev-2.24.tar.gz \
    --continue --directory-prefix=/sources &&

md5sum -c ${SCRIPTPATH}/md5-libblockdev &&

tar xf /sources/libblockdev-2.24.tar.gz -C /sources/ &&

cd /sources/libblockdev-2.24 &&

./configure --prefix=/usr     \
            --sysconfdir=/etc \
            --with-python3    \
            --without-nvdimm  \
            --without-dm   &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
${log} `basename "$0"` " built" blfs_all &&

make install &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
