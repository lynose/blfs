#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/telepathy-mission-control-5.16.5
 then
  rm -rf /sources/telepathy-mission-control-5.16.5
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download https://telepathy.freedesktop.org/releases/telepathy-mission-control/telepathy-mission-control-5.16.5.tar.gz \
        /sources


md5sum -c ${SCRIPTPATH}/md5-telepathy-mission-control-5.16.5.tar.gz &&

tar xf /sources/telepathy-mission-control-5.16.5.tar.gz -C /sources/ &&

cd /sources/telepathy-mission-control-5.16.5 &&

./configure --prefix=/usr --disable-static &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
${log} `basename "$0"` " built" blfs_all &&

as_root make install &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
