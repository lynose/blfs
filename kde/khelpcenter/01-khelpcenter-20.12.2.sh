#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/khelpcenter-20.12.2
 then
  rm -rf /sources/khelpcenter-20.12.2
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download http://download.kde.org/stable/release-service/20.12.2/src/khelpcenter-20.12.2.tar.xz \
    /sources &&

md5sum -c ${SCRIPTPATH}/md5-khelpcenter &&

tar xf /sources/khelpcenter-20.12.2.tar.xz -C /sources/ &&

cd /sources/khelpcenter-20.12.2 &&

mkdir build &&
cd    build &&

cmake -DCMAKE_INSTALL_PREFIX=$KF5_PREFIX \
      -DCMAKE_BUILD_TYPE=Release         \
      -DBUILD_TESTING=OFF                \
      -Wno-dev ..  &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
${log} `basename "$0"` " built" blfs_all &&

as_root make install  &&

as_root mv -v $KF5_PREFIX/share/kde4/services/khelpcenter.desktop /usr/share/applications/ &&
as_root rm -rv $KF5_PREFIX/share/kde4 &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
