#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/x265_3.4
 then
  rm -rf /sources/x265_3.4
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download http://anduin.linuxfromscratch.org/BLFS/x265/x265_3.4.tar.gz \
    /sources &&

md5sum -c ${SCRIPTPATH}/md5-x265 &&

tar xf /sources/x265_3.4.tar.gz -C /sources/ &&

cd /sources/x265_3.4 &&

mkdir bld &&
cd    bld &&

cmake -DCMAKE_INSTALL_PREFIX=/usr ../source &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
${log} `basename "$0"` " built" blfs_all &&

as_root make install &&
as_root rm -vf /usr/lib/libx265.a &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
