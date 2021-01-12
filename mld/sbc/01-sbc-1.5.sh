#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/sbc-1.5
 then
  rm -rf /sources/sbc-1.5
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download https://www.kernel.org/pub/linux/bluetooth/sbc-1.5.tar.xz \
    /sources &&

md5sum -c ${SCRIPTPATH}/md5-sbc &&

tar xf /sources/sbc-1.5.tar.xz -C /sources/ &&

cd /sources/sbc-1.5 &&

./configure --prefix=/usr --disable-static &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
${log} `basename "$0"` " built" blfs_all &&

as_root make install &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
