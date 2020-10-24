#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/libsamplerate-0.1.9
 then
  rm -rf /sources/libsamplerate-0.1.9
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

wget http://www.mega-nerd.com/SRC/libsamplerate-0.1.9.tar.gz \
    --continue --directory-prefix=/sources &&

md5sum -c ${SCRIPTPATH}/md5-libsamplerate &&

tar xf /sources/libsamplerate-0.1.9.tar.gz -C /sources/ &&

cd /sources/libsamplerate-0.1.9 &&

./configure --prefix=/usr --disable-static &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
${log} `basename "$0"` " built" blfs_all &&

make check &&
${log} `basename "$0"` " check succeed" blfs_all &&

make htmldocdir=/usr/share/doc/libsamplerate-0.1.9 install &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
