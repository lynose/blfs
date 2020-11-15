#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/libatasmart-0.19
 then
  rm -rf /sources/libatasmart-0.19
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download http://0pointer.de/public/libatasmart-0.19.tar.xz \
    /sources &&

md5sum -c ${SCRIPTPATH}/md5-libatasmart &&

tar xf /sources/libatasmart-0.19.tar.xz -C /sources/ &&

cd /sources/libatasmart-0.19 &&

./configure --prefix=/usr --disable-static &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
${log} `basename "$0"` " built" blfs_all &&

as_root make docdir=/usr/share/doc/libatasmart-0.19 install &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
