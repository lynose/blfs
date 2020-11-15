#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/volume_key-volume_key-0.3.12
 then
  rm -rf /sources/volume_key-volume_key-0.3.12
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download https://github.com/felixonmars/volume_key/archive/volume_key-0.3.12.tar.gz \
    /sources &&

md5sum -c ${SCRIPTPATH}/md5-volume_key &&

tar xf /sources/volume_key-0.3.12.tar.gz -C /sources/ &&

cd /sources/volume_key-volume_key-0.3.12 &&

autoreconf -fiv              &&
./configure --prefix=/usr    \
            --without-python &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
${log} `basename "$0"` " built" blfs_all &&

as_root make install &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
