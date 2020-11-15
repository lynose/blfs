#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/tiff-4.1.0
 then
  rm -rf /sources/tiff-4.1.0
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download http://download.osgeo.org/libtiff/tiff-4.1.0.tar.gz \
    /sources &&

md5sum -c ${SCRIPTPATH}/md5-tiff &&

tar xf /sources/tiff-4.1.0.tar.gz -C /sources/ &&

cd /sources/tiff-4.1.0 &&

mkdir -p libtiff-build &&
cd       libtiff-build &&

cmake -DCMAKE_INSTALL_DOCDIR=/usr/share/doc/libtiff-4.1.0 \
      -DCMAKE_INSTALL_PREFIX=/usr -G Ninja .. &&
${log} `basename "$0"` " configured" blfs_all &&

ninja &&
${log} `basename "$0"` " built" blfs_all &&

ninja test &&
${log} `basename "$0"` " check succeed" blfs_all &&

as_root ninja install &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
