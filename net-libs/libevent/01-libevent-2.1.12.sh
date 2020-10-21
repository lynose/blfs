#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/libevent-2.1.12-stable
 then
  rm -rf /sources/libevent-2.1.12-stable
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

wget https://github.com/libevent/libevent/releases/download/release-2.1.12-stable/libevent-2.1.12-stable.tar.gz \
    --continue --directory-prefix=/sources &&

md5sum -c ${SCRIPTPATH}/md5-libevent &&

tar xf /sources/libevent-2.1.12-stable.tar.gz -C /sources/ &&

cd /sources/libevent-2.1.12-stable &&

./configure --prefix=/usr --disable-static &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
doxygen Doxyfile &&
${log} `basename "$0"` " built" blfs_all &&

make verify &&
${log} `basename "$0"` " check succeed" blfs_all &&

make install &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
