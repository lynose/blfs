#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/pipewire-0.3.9
 then
  rm -rf /sources/pipewire-0.3.9
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

wget https://github.com/PipeWire/pipewire/archive/0.3.9/pipewire-0.3.9.tar.gz \
    --continue --directory-prefix=/sources &&

md5sum -c ${SCRIPTPATH}/md5-pipewire &&

tar xf /sources/pipewire-0.3.9.tar.gz -C /sources/ &&

cd /sources/pipewire-0.3.9 &&

mkdir build &&
cd    build &&

meson --prefix=/usr           \
      -Djack=false            \
      -Dpipewire-jack=false   \
      -Dvulkan=false          \
      .. &&
${log} `basename "$0"` " configured" blfs_all &&

ninja &&
${log} `basename "$0"` " built" blfs_all &&

ninja test &&
${log} `basename "$0"` " check succeed" blfs_all &&

ninja install &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
