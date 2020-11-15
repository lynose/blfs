#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/at-spi2-core-2.36.0
 then
  rm -rf /sources/at-spi2-core-2.36.0
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download http://ftp.gnome.org/pub/gnome/sources/at-spi2-core/2.36/at-spi2-core-2.36.0.tar.xz \
    /sources &&

md5sum -c ${SCRIPTPATH}/md5-at-spi2-core &&

tar xf /sources/at-spi2-core-2.36.0.tar.xz -C /sources/ &&

cd /sources/at-spi2-core-2.36.0 &&

mkdir build &&
cd    build &&

meson --prefix=/usr --sysconfdir=/etc  ..  &&
${log} `basename "$0"` " configured" blfs_all &&

ninja &&
${log} `basename "$0"` " built" blfs_all &&

ninja test &&
${log} `basename "$0"` " unexpected check succeed" blfs_all
${log} `basename "$0"` " expected check fail?" blfs_all &&

as_root ninja install &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
