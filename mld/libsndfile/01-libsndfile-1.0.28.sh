#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/libsndfile-1.0.28
 then
  rm -rf /sources/libsndfile-1.0.28
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download http://www.mega-nerd.com/libsndfile/files/libsndfile-1.0.28.tar.gz \
    /sources &&

md5sum -c ${SCRIPTPATH}/md5-libsndfile &&

tar xf /sources/libsndfile-1.0.28.tar.gz -C /sources/ &&

cd /sources/libsndfile-1.0.28 &&

./configure --prefix=/usr    \
            --disable-static \
            --docdir=/usr/share/doc/libsndfile-1.0.28 &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
${log} `basename "$0"` " built" blfs_all &&

make check &&
${log} `basename "$0"` " check succeed" blfs_all &&

as_root make install &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
