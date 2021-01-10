#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/libgdata-0.17.13
 then
  rm -rf /sources/libgdata-0.17.13
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download http://ftp.gnome.org/pub/gnome/sources/libgdata/0.17/libgdata-0.17.13.tar.xz \
    /sources &&

md5sum -c ${SCRIPTPATH}/md5-libgdata &&

tar xf /sources/libgdata-0.17.13.tar.xz -C /sources/ &&

cd /sources/libgdata-0.17.13 &&



mkdir build &&
cd    build &&

meson --prefix=/usr -Dalways_build_tests=false ..  &&
${log} `basename "$0"` " configured" blfs_all &&

ninja &&
${log} `basename "$0"` " built" blfs_all &&

# TODO rework
# if [ ${ENABLE_TEST} == true ]
#  then
#   ninja test &&
#   ${log} `basename "$0"` " check succeed" blfs_all ||
#   ${log} `basename "$0"` " expected check fail?" blfs_all
# fi

as_root ninja install &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
