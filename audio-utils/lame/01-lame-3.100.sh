#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/lame-3.100
 then
  rm -rf /sources/lame-3.100
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

if [ ! -f /sources/lame-3.100.tar.gz ];  
 then
  wget https://downloads.sourceforge.net/lame/lame-3.100.tar.gz \
    --continue --directory-prefix=/sources
fi
md5sum -c ${SCRIPTPATH}/md5-lame &&

tar xf /sources/lame-3.100.tar.gz -C /sources/ &&

cd /sources/lame-3.100 &&

./configure --prefix=/usr --enable-mp3rtp --disable-static &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
${log} `basename "$0"` " built" blfs_all &&

make test &&
${log} `basename "$0"` " check succeed" blfs_all &&

make pkghtmldir=/usr/share/doc/lame-3.100 install &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
