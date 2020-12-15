#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/rpcsvc-proto-1.4.2
 then
  rm -rf /sources/rpcsvc-proto-1.4.2
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download https://github.com/thkukuk/rpcsvc-proto/releases/download/v1.4.2/rpcsvc-proto-1.4.2.tar.xz \
        /sources


md5sum -c ${SCRIPTPATH}/md5-rpcsvc-proto &&

tar xf /sources/rpcsvc-proto-1.4.2.tar.xz -C /sources/ &&

cd /sources/rpcsvc-proto-1.4.2 &&

./configure --sysconfdir=/etc &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
${log} `basename "$0"` " built" blfs_all &&

as_root make install &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
