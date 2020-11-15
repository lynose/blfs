#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/libcanberra-0.30
 then
  rm -rf /sources/libcanberra-0.30
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download http://0pointer.de/lennart/projects/libcanberra/libcanberra-0.30.tar.xz \
    /sources &&

md5sum -c ${SCRIPTPATH}/md5-libcanberra &&

tar xf /sources/libcanberra-0.30.tar.xz -C /sources/ &&

cd /sources/libcanberra-0.30 &&

./configure --prefix=/usr --disable-oss  &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
${log} `basename "$0"` " built" blfs_all &&

make docdir=/usr/share/doc/libcanberra-0.30 install &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
