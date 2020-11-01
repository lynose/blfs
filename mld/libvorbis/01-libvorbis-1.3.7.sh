#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/libvorbis-1.3.7
 then
  rm -rf /sources/libvorbis-1.3.7
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

wget https://downloads.xiph.org/releases/vorbis/libvorbis-1.3.7.tar.xz \
    --continue --directory-prefix=/sources &&

md5sum -c ${SCRIPTPATH}/md5-libvorbis &&

tar xf /sources/libvorbis-1.3.7.tar.xz -C /sources/ &&

cd /sources/libvorbis-1.3.7 &&

./configure --prefix=/usr --disable-static &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
${log} `basename "$0"` " built" blfs_all &&

make check &&
${log} `basename "$0"` " check succeed" blfs_all &&

make install &&
install -v -m644 doc/Vorbis* /usr/share/doc/libvorbis-1.3.7 &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
