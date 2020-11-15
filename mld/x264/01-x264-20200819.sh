#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/x264-20200819
 then
  rm -rf /sources/x264-20200819
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download http://anduin.linuxfromscratch.org/BLFS/x264/x264-20200819.tar.xz \
    /sources &&

md5sum -c ${SCRIPTPATH}/md5-x264 &&

tar xf /sources/x264-20200819.tar.xz -C /sources/ &&

cd /sources/x264-20200819 &&

./configure --prefix=/usr \
            --enable-shared \
            --disable-cli &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
${log} `basename "$0"` " built" blfs_all &&

as_root make install &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
