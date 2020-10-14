#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/alsa-firmware-1.2.1
 then
  rm -rf /sources/alsa-firmware-1.2.1
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

wget https://www.alsa-project.org/files/pub/firmware/alsa-firmware-1.2.1.tar.bz2 \
    --continue --directory-prefix=/sources &&

md5sum -c ${SCRIPTPATH}/md5-alsa-firmware &&

tar xf /sources/alsa-firmware-1.2.1.tar.bz2 -C /sources/ &&

cd /sources/alsa-firmware-1.2.1 &&

./configure --prefix=/usr &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
${log} `basename "$0"` " built" blfs_all &&

make install &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
