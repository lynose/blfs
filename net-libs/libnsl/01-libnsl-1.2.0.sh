#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/libnsl-1.2.0
 then
  rm -rf /sources/libnsl-1.2.0
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download https://github.com/thkukuk/libnsl/archive/v1.2.0/libnsl-1.2.0.tar.gz \
        /sources


md5sum -c ${SCRIPTPATH}/md5-libnsl &&

tar xf /sources/libnsl-1.2.0.tar.gz -C /sources/ &&

cd /sources/libnsl-1.2.0 &&

autoreconf -fi                &&
./configure --sysconfdir=/etc  &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
${log} `basename "$0"` " built" blfs_all &&

as_root make install                  &&
as_root mv -v /usr/lib/libnsl.so.2* /lib &&
as_root ln -sfv ../../lib/libnsl.so.2.0.0 /usr/lib/libnsl.so &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
