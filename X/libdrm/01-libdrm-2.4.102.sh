#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/libdrm-2.4.102
 then
  rm -rf /sources/libdrm-2.4.102
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download https://dri.freedesktop.org/libdrm/libdrm-2.4.102.tar.xz \
    /sources &&

md5sum -c ${SCRIPTPATH}/md5-libdrm &&

tar xf /sources/libdrm-2.4.102.tar.xz -C /sources/ &&

cd /sources/libdrm-2.4.102 &&

mkdir build &&
cd    build &&

meson --prefix=$XORG_PREFIX -Dudev=true &&
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
