#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/libgudev-233
 then
  rm -rf /sources/libgudev-233
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download http://ftp.gnome.org/pub/gnome/sources/libgudev/233/libgudev-233.tar.xz \
    /sources &&

md5sum -c ${SCRIPTPATH}/md5-libgudev &&

tar xf /sources/libgudev-233.tar.xz -C /sources/ &&

cd /sources/libgudev-233 &&

./configure --prefix=/usr --disable-umockdev &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
${log} `basename "$0"` " built" blfs_all &&

as_root make install &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
