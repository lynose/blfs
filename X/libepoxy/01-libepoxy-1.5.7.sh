#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/libepoxy-1.5.7
 then
  rm -rf /sources/libepoxy-1.5.7
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download https://github.com/anholt/libepoxy/releases/download/1.5.7/libepoxy-1.5.7.tar.xz \
    /sources &&

md5sum -c ${SCRIPTPATH}/md5-libepoxy &&

tar xf /sources/libepoxy-1.5.7.tar.xz -C /sources/ &&

cd /sources/libepoxy-1.5.7 &&

mkdir build &&
cd    build &&

meson --prefix=/usr -Ddocs=true .. &&
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
