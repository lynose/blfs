#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/cairo-1.17.2+f93fc72c03e
 then
  rm -rf /sources/cairo-1.17.2+f93fc72c03e
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download http://anduin.linuxfromscratch.org/BLFS/cairo/cairo-1.17.2+f93fc72c03e.tar.xz \
    /sources &&

md5sum -c ${SCRIPTPATH}/md5-cairo &&

tar xf /sources/cairo-1.17.2+f93fc72c03e.tar.xz -C /sources/ &&

cd /sources/cairo-1.17.2+f93fc72c03e &&

autoreconf -fiv             &&
./configure --prefix=/usr    \
            --disable-static \
            --enable-tee &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
${log} `basename "$0"` " built" blfs_all &&

as_root make install &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
