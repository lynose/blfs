#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/iw-5.4.tar.xz
 then
  rm -rf /sources/iw-5.4.tar.xz
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download https://www.kernel.org/pub/software/network/iw/iw-5.4.tar.xz \
        /sources


md5sum -c ${SCRIPTPATH}/md5-iw &&

tar xf /sources/iw-5.4.tar.xz -C /sources/ &&

cd /sources/iw-5.4.tar.xz &&

sed -i "/INSTALL.*gz/s/.gz//" Makefile &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
${log} `basename "$0"` " built" blfs_all &&

as_root make SBINDIR=/sbin install &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
