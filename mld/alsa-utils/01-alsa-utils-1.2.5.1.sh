#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/alsa-utils-1.2.5.1
 then
  rm -rf /sources/alsa-utils-1.2.5.1
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download https://www.alsa-project.org/files/pub/utils/alsa-utils-1.2.5.1.tar.bz2 \
    /sources &&

md5sum -c ${SCRIPTPATH}/md5-alsa-utils &&

tar xf /sources/alsa-utils-1.2.5.1.tar.bz2 -C /sources/ &&

cd /sources/alsa-utils-1.2.5.1 &&

./configure --disable-alsaconf \
            --with-curses=ncursesw &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
${log} `basename "$0"` " built" blfs_all &&

as_root make install &&
as_root alsactl -L store &&
if [ $EUID != 0 ]
 then
  as_root usermod -a -G audio $USER
fi
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
