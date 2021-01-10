#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/telepathy-mission-control-5.16.6
 then
  rm -rf /sources/telepathy-mission-control-5.16.6
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download https://telepathy.freedesktop.org/releases/telepathy-mission-control/telepathy-mission-control-5.16.6.tar.gz \
        /sources


md5sum -c ${SCRIPTPATH}/md5-telepathy-mission-control &&

tar xf /sources/telepathy-mission-control-5.16.6.tar.gz -C /sources/ &&

cd /sources/telepathy-mission-control-5.16.6 &&

PYTHON=python3 \
./configure --prefix=/usr --disable-static --enable-gtk-doc &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
${log} `basename "$0"` " built" blfs_all &&

if [ ${ENABLE_TEST} == true ]
 then
  make check &&
  ${log} `basename "$0"` " check succeed" blfs_all ||
  ${log} `basename "$0"` " expected check fail?" blfs_all
fi

as_root make install &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
