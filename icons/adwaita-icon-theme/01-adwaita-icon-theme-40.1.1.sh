#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/adwaita-icon-theme-40.1.1
 then
  rm -rf /sources/adwaita-icon-theme-40.1.1
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download https://download.gnome.org/sources/adwaita-icon-theme/40/adwaita-icon-theme-40.1.1.tar.xz \
    /sources &&

md5sum -c ${SCRIPTPATH}/md5-adwaita-icon-theme &&

tar xf /sources/adwaita-icon-theme-40.1.1.tar.xz -C /sources/ &&

cd /sources/adwaita-icon-theme-40.1.1 &&

./configure --prefix=/usr &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
${log} `basename "$0"` " built" blfs_all &&

as_root make install &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
