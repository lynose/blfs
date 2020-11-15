#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/libmbim-1.24.2
 then
  rm -rf /sources/libmbim-1.24.2
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download https://www.freedesktop.org/software/libmbim/libmbim-1.24.2.tar.xz \
    /sources &&

md5sum -c ${SCRIPTPATH}/md5-libmbim &&

tar xf /sources/libmbim-1.24.2.tar.xz -C /sources/ &&

cd /sources/libmbim-1.24.2 &&

./configure --prefix=/usr --disable-static &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
${log} `basename "$0"` " built" blfs_all &&

make check &&
${log} `basename "$0"` " check succeed" blfs_all &&

as_root make install &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
