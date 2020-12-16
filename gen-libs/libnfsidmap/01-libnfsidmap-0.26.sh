#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/libnfsidmap-0.26
 then
  rm -rf /sources/libnfsidmap-0.26
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download https://fedorapeople.org/~steved/libnfsidmap/0.26/libnfsidmap-0.26.tar.bz2 \
        /sources


md5sum -c ${SCRIPTPATH}/md5-libnfsidmap &&

tar xf /sources/libnfsidmap-0.26.tar.bz2 -C /sources/ &&

cd /sources/libnfsidmap-0.26 &&

./configure --prefix=/usr     \
            --sysconfdir=/etc \
            --disable-static &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
${log} `basename "$0"` " built" blfs_all &&

as_root make install &&
as_root mv -v /usr/lib/libnfsidmap.so.* /lib &&
as_root ln -sfv ../../lib/$(readlink /usr/lib/libnfsidmap.so) /usr/lib/libnfsidmap.so &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
