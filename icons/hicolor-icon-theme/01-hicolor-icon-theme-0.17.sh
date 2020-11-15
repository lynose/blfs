#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/hicolor-icon-theme-0.17
 then
  rm -rf /sources/hicolor-icon-theme-0.17
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download https://icon-theme.freedesktop.org/releases/hicolor-icon-theme-0.17.tar.xz \
    /sources &&

md5sum -c ${SCRIPTPATH}/md5-hicolor-icon-theme &&

tar xf /sources/hicolor-icon-theme-0.17.tar.xz -C /sources/ &&

cd /sources/hicolor-icon-theme-0.17 &&

./configure --prefix=/usr &&
${log} `basename "$0"` " configured" blfs_all &&

as_root make install &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
