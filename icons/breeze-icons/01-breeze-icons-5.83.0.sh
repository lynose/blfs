#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/breeze-icons-5.83.0
 then
  rm -rf /sources/breeze-icons-5.83.0
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download http://download.kde.org/stable/frameworks/5.83/breeze-icons-5.83.0.tar.xz \
    /sources &&

md5sum -c ${SCRIPTPATH}/md5-breeze-icons &&

tar xf /sources/breeze-icons-5.83.0.tar.xz -C /sources/ &&

cd /sources/breeze-icons-5.83.0 &&

mkdir build &&
cd    build &&

cmake -DCMAKE_INSTALL_PREFIX=/usr \
      -DBUILD_TESTING=OFF         \
      -Wno-dev .. &&
${log} `basename "$0"` " configured" blfs_all &&

as_root make install &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
