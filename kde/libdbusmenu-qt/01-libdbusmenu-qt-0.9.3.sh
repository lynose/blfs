#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/libdbusmenu-qt-0.9.3+16.04.20160218
 then
  rm -rf /sources/libdbusmenu-qt-0.9.3+16.04.20160218
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download http://launchpad.net/ubuntu/+archive/primary/+files/libdbusmenu-qt_0.9.3+16.04.20160218.orig.tar.gz \
    /sources &&

md5sum -c ${SCRIPTPATH}/md5-libdbusmenu-qt &&

tar xf /sources/libdbusmenu-qt_0.9.3+16.04.20160218.orig.tar.gz -C /sources/ &&

cd /sources/libdbusmenu-qt-0.9.3+16.04.20160218 &&

mkdir build &&
cd    build &&

cmake -DCMAKE_INSTALL_PREFIX=/usr \
      -DCMAKE_BUILD_TYPE=Release  \
      -DWITH_DOC=OFF              \
      -Wno-dev .. &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
${log} `basename "$0"` " built" blfs_all &&

as_root make install &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
