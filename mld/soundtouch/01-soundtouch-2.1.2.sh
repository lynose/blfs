#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/soundtouch-2.1.2
 then
  rm -rf /sources/soundtouch-2.1.2
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

wget https://gitlab.com/soundtouch/soundtouch/-/archive/2.1.2/soundtouch-2.1.2.tar.bz2 \
    --continue --directory-prefix=/sources &&

md5sum -c ${SCRIPTPATH}/md5-soundtouch &&

tar xf /sources/soundtouch-2.1.2.tar.bz2 -C /sources/ &&

cd /sources/soundtouch-2.1.2 &&

./bootstrap &&
./configure --prefix=/usr \
            --enable-openmp \
            --docdir=/usr/share/doc/soundtouch-2.1.2 &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
${log} `basename "$0"` " built" blfs_all &&

make install &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
