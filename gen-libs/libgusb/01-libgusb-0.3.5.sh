#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/libgusb-0.3.5
 then
  rm -rf /sources/libgusb-0.3.5
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

wget https://people.freedesktop.org/~hughsient/releases/libgusb-0.3.5.tar.xz \
    --continue --directory-prefix=/sources &&

md5sum -c ${SCRIPTPATH}/md5-libgusb &&

tar xf /sources/libgusb-0.3.5.tar.xz -C /sources/ &&

cd /sources/libgusb-0.3.5 &&

mkdir build &&
cd    build &&

meson --prefix=/usr -Ddocs=true ..  &&
${log} `basename "$0"` " configured" blfs_all &&

ninja &&
${log} `basename "$0"` " built" blfs_all &&

ninja test &&
${log} `basename "$0"` " check succeed" blfs_all &&

ninja install &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
