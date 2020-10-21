#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/adwaita-icon-theme-3.36.1
 then
  rm -rf /sources/adwaita-icon-theme-3.36.1
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

wget http://ftp.gnome.org/pub/gnome/sources/adwaita-icon-theme/3.36/adwaita-icon-theme-3.36.1.tar.xz \
    --continue --directory-prefix=/sources &&

md5sum -c ${SCRIPTPATH}/md5-adwaita-icon-theme &&

tar xf /sources/adwaita-icon-theme-3.36.1.tar.xz -C /sources/ &&

cd /sources/adwaita-icon-theme-3.36.1 &&

./configure --prefix=/usr &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
${log} `basename "$0"` " built" blfs_all &&

make install &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
