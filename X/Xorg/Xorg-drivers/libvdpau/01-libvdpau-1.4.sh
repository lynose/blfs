#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/libvdpau-1.4
 then
  rm -rf /sources/libvdpau-1.4
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download https://gitlab.freedesktop.org/vdpau/libvdpau/-/archive/1.4/libvdpau-1.4.tar.bz2 \
    /sources &&

md5sum -c ${SCRIPTPATH}/md5-libvdpau &&

tar xf /sources/libvdpau-1.4.tar.bz2 -C /sources/ &&

cd /sources/libvdpau-1.4 &&

mkdir build &&
cd    build &&

meson --prefix=$XORG_PREFIX .. &&
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
