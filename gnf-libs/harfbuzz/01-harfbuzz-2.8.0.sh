#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/harfbuzz-2.8.0
 then
  rm -rf /sources/harfbuzz-2.8.0
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download https://github.com/harfbuzz/harfbuzz/releases/download/2.8.0/harfbuzz-2.8.0.tar.xz \
    /sources &&

md5sum -c ${SCRIPTPATH}/md5-harfbuzz &&

tar xf /sources/harfbuzz-2.8.0.tar.xz -C /sources/ &&

cd /sources/harfbuzz-2.8.0 &&

mkdir build &&
cd    build &&

meson --prefix=/usr -Dgraphite=enabled -Dbenchmark=disabled &&
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
