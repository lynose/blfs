#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/plasma-wayland-protocols-1.1.1
 then
  rm -rf /sources/plasma-wayland-protocols-1.1.1
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

wget https://download.kde.org/stable/plasma-wayland-protocols/plasma-wayland-protocols-1.1.1.tar.xz \
    --continue --directory-prefix=/sources &&

md5sum -c ${SCRIPTPATH}/md5-plasma-wayland-protocols &&

tar xf /sources/plasma-wayland-protocols-1.1.1.tar.xz -C /sources/ &&

cd /sources/plasma-wayland-protocols-1.1.1 &&

mkdir build &&
cd    build &&

cmake -DCMAKE_INSTALL_PREFIX=/usr .. &&
${log} `basename "$0"` " configured" blfs_all &&

make install &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
