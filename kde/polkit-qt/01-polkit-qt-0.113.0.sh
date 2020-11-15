#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/polkit-qt-1-0.113.0
 then
  rm -rf /sources/polkit-qt-1-0.113.0
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download https://download.kde.org/stable/polkit-qt-1/polkit-qt-1-0.113.0.tar.xz \
    /sources &&

md5sum -c ${SCRIPTPATH}/md5-polkit-qt &&

tar xf /sources/polkit-qt-1-0.113.0.tar.xz -C /sources/ &&

cd /sources/polkit-qt-1-0.113.0 &&

mkdir build &&
cd    build &&

cmake -DCMAKE_INSTALL_PREFIX=/usr \
      -DCMAKE_BUILD_TYPE=Release  \
      -Wno-dev .. &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
${log} `basename "$0"` " built" blfs_all &&

as_root make install &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
