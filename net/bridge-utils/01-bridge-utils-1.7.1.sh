#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/bridge-utils-1.7.1
 then
  rm -rf /sources/bridge-utils-1.7.1
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download https://www.kernel.org/pub/linux/utils/net/bridge-utils/bridge-utils-1.7.1.tar.xz \
        /sources


md5sum -c ${SCRIPTPATH}/md5-bridge-utils &&

tar xf /sources/bridge-utils-1.7.1.tar.xz -C /sources/ &&

cd /sources/bridge-utils-1.7.1 &&

autoconf                  &&
./configure --prefix=/usr  &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
${log} `basename "$0"` " built" blfs_all &&

as_root make install &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
