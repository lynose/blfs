#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/plasma-wayland-protocols-1.1.1
 then
  as_root rm -rf /sources/plasma-wayland-protocols-1.1.1
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download https://download.kde.org/stable/plasma-wayland-protocols/plasma-wayland-protocols-1.1.1.tar.xz \
    /sources &&

md5sum -c ${SCRIPTPATH}/md5-plasma-wayland-protocols &&

tar xf /sources/plasma-wayland-protocols-1.1.1.tar.xz -C /sources/ &&

cd /sources/plasma-wayland-protocols-1.1.1 &&

mkdir build &&
cd    build &&

cmake -DCMAKE_INSTALL_PREFIX=/usr .. &&
${log} `basename "$0"` " configured" blfs_all &&

as_root make install &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
