#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/extra-cmake-modules-5.77.0
 then
  rm -rf /sources/extra-cmake-modules-5.77.0
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download http://download.kde.org/stable/frameworks/5.77/extra-cmake-modules-5.77.0.tar.xz \
    /sources &&

md5sum -c ${SCRIPTPATH}/md5-extra-cmake-modules &&

tar xf /sources/extra-cmake-modules-5.77.0.tar.xz -C /sources/ &&

cd /sources/extra-cmake-modules-5.77.0 &&

sed -i '/"lib64"/s/64//' kde-modules/KDEInstallDirs.cmake &&

sed -e '/PACKAGE_INIT/i set(SAVE_PACKAGE_PREFIX_DIR "${PACKAGE_PREFIX_DIR}")' \
    -e '/^include/a set(PACKAGE_PREFIX_DIR "${SAVE_PACKAGE_PREFIX_DIR}")' \
    -i ECMConfig.cmake.in &&

mkdir build &&
cd    build &&

cmake -DCMAKE_INSTALL_PREFIX=/usr .. &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
${log} `basename "$0"` " built" blfs_all &&

as_root make install &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
