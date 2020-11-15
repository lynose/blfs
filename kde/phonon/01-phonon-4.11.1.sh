#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/phonon-4.11.1
 then
  rm -rf /sources/phonon-4.11.1
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download https://download.kde.org/stable/phonon/4.11.1/phonon-4.11.1.tar.xz \
    /sources &&

md5sum -c ${SCRIPTPATH}/md5-phonon &&

tar xf /sources/phonon-4.11.1.tar.xz -C /sources/ &&

cd /sources/phonon-4.11.1 &&

mkdir build &&
cd    build &&

cmake -DCMAKE_INSTALL_PREFIX=/usr \
      -DCMAKE_BUILD_TYPE=Release  \
      .. &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
${log} `basename "$0"` " built" blfs_all &&

as_root make install &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
