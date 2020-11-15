#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/xdg-utils-1.1.3
 then
  rm -rf /sources/xdg-utils-1.1.3
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download https://portland.freedesktop.org/download/xdg-utils-1.1.3.tar.gz \
    /sources &&

md5sum -c ${SCRIPTPATH}/md5-xdg-utils &&

tar xf /sources/xdg-utils-1.1.3.tar.gz -C /sources/ &&

cd /sources/xdg-utils-1.1.3 &&

./configure --prefix=/usr --mandir=/usr/share/man &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
${log} `basename "$0"` " built" blfs_all &&

as_root make install &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
