#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/libkdcraw-20.12.2
 then
  rm -rf /sources/libkdcraw-20.12.2
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download http://download.kde.org/stable/release-service/20.12.2/src/libkdcraw-20.12.2.tar.xz \
    /sources &&

md5sum -c ${SCRIPTPATH}/md5-libkdcraw &&

tar xf /sources/libkdcraw-20.12.2.tar.xz -C /sources/ &&

cd /sources/libkdcraw-20.12.2 &&


mkdir build &&
cd    build &&

cmake -DCMAKE_INSTALL_PREFIX=$KDE_PREFIX \
      -DCMAKE_BUILD_TYPE=Release         \
      -DBUILD_TESTING=OFF                \
      -Wno-dev ..  &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
${log} `basename "$0"` " built" blfs_all &&

as_root make install &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
