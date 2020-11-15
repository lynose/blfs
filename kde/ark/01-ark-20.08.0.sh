#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/ark-20.08.0
 then
  rm -rf /sources/ark-20.08.0
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download http://download.kde.org/stable/release-service/20.08.0/src/ark-20.08.0.tar.xz \
    /sources &&

check_and_download http://www.linuxfromscratch.org/patches/blfs/10.0/ark-20.08.0-upstream_fix-1.patch \
    /sources &&
    
md5sum -c ${SCRIPTPATH}/md5-ark &&

tar xf /sources/ark-20.08.0.tar.xz -C /sources/ &&

cd /sources/ark-20.08.0 &&

patch -Np1 -i ../ark-20.08.0-upstream_fix-1.patch &&

mkdir build &&
cd    build &&

cmake -DCMAKE_INSTALL_PREFIX=$KF5_PREFIX \
      -DCMAKE_BUILD_TYPE=Release         \
      -DBUILD_TESTING=OFF                \
      -Wno-dev .. &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
${log} `basename "$0"` " built" blfs_all &&

as_root make install &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
