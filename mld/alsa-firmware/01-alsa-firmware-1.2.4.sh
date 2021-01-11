#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/alsa-firmware-1.2.4
 then
  rm -rf /sources/alsa-firmware-1.2.4
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download https://www.alsa-project.org/files/pub/firmware/alsa-firmware-1.2.4.tar.bz2 \
    /sources &&

md5sum -c ${SCRIPTPATH}/md5-alsa-firmware &&

tar xf /sources/alsa-firmware-1.2.4.tar.bz2 -C /sources/ &&

cd /sources/alsa-firmware-1.2.4 &&

./configure --prefix=/usr &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
${log} `basename "$0"` " built" blfs_all &&

as_root make install &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
