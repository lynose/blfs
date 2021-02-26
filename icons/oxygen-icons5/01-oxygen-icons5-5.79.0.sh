#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/oxygen-icons5-5.79.0
 then
  rm -rf /sources/oxygen-icons5-5.79.0
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download http://download.kde.org/stable/frameworks/5.79/oxygen-icons5-5.79.0.tar.xz \
    /sources &&

md5sum -c ${SCRIPTPATH}/md5-oxygen-icons5 &&

tar xf /sources/oxygen-icons5-5.79.0.tar.xz -C /sources/ &&

cd /sources/oxygen-icons5-5.79.0 &&

sed -i '/( oxygen/ s/)/scalable )/' CMakeLists.txt &&

mkdir build &&
cd    build &&

cmake -DCMAKE_INSTALL_PREFIX=/usr -Wno-dev .. &&
${log} `basename "$0"` " configured" blfs_all &&

as_root make install &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
