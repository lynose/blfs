#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/c-ares-1.16.1
 then
  rm -rf /sources/c-ares-1.16.1
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

wget https://c-ares.haxx.se/download/c-ares-1.16.1.tar.gz \
    --continue --directory-prefix=/sources &&

md5sum -c ${SCRIPTPATH}/md5-c-ares &&

tar xf /sources/c-ares-1.16.1.tar.gz -C /sources/ &&

cd /sources/c-ares-1.16.1 &&

mkdir build &&
cd    build &&

cmake  -DCMAKE_INSTALL_PREFIX=/usr .. &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
${log} `basename "$0"` " built" blfs_all &&

make install &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
