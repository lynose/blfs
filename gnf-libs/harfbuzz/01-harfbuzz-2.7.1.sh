#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/harfbuzz-2.7.1
 then
  rm -rf /sources/harfbuzz-2.7.1
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download https://github.com/harfbuzz/harfbuzz/releases/download/2.7.1/harfbuzz-2.7.1.tar.xz \
    /sources &&

md5sum -c ${SCRIPTPATH}/md5-harfbuzz &&

tar xf /sources/harfbuzz-2.7.1.tar.xz -C /sources/ &&

cd /sources/harfbuzz-2.7.1 &&

./configure --prefix=/usr --with-gobject --with-graphite2 &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
${log} `basename "$0"` " built" blfs_all &&

make check &&
${log} `basename "$0"` " check succeed" blfs_all &&

as_root make install &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
