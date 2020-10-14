#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/alsa-plugins-1.2.2
 then
  rm -rf /sources/alsa-plugins-1.2.2
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

wget https://www.alsa-project.org/files/pub/plugins/alsa-plugins-1.2.2.tar.bz2 \
    --continue --directory-prefix=/sources &&

md5sum -c ${SCRIPTPATH}/md5-alsa-plugins &&

tar xf /sources/alsa-plugins-1.2.2.tar.bz2 -C /sources/ &&

cd /sources/alsa-plugins-1.2.2 &&

./configure --sysconfdir=/etc &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
${log} `basename "$0"` " built" blfs_all &&

make install &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
