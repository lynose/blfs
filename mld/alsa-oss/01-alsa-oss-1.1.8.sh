#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/alsa-oss-1.1.8
 then
  rm -rf /sources/alsa-oss-1.1.8
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

wget https://www.alsa-project.org/files/pub/oss-lib/alsa-oss-1.1.8.tar.bz2 \
    --continue --directory-prefix=/sources &&

md5sum -c ${SCRIPTPATH}/md5-alsa-oss &&

tar xf /sources/alsa-oss-1.1.8.tar.bz2 -C /sources/ &&

cd /sources/alsa-oss-1.1.8 &&

./configure --disable-static &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
${log} `basename "$0"` " built" blfs_all &&

make install &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
