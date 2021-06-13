#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/pipewire-0.3.30
 then
  as_root rm -rf /sources/pipewire-0.3.30
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download https://github.com/PipeWire/pipewire/archive/0.3.30/pipewire-0.3.30.tar.gz \
    /sources &&

md5sum -c ${SCRIPTPATH}/md5-pipewire &&

tar xf /sources/pipewire-0.3.30.tar.gz -C /sources/ &&

cd /sources/pipewire-0.3.30 &&

mkdir build &&
cd    build &&

meson --prefix=/usr  --buildtype=release         \
      -Ddocs=enabled   -Dman=true       \
      .. &&
${log} `basename "$0"` " configured" blfs_all &&

ninja &&
${log} `basename "$0"` " built" blfs_all &&

if [ ${ENABLE_TEST} == true ]
 then
  ninja test &&
  ${log} `basename "$0"` " check succeed" blfs_all ||
  ${log} `basename "$0"` " expected check fail?" blfs_all
fi


as_root ninja install &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
