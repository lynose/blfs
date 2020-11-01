#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/libmng-2.0.3
 then
  rm -rf /sources/libmng-2.0.3
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

if [ ! -f /sources/libmng-2.0.3.tar.xz ];  
 then
  wget https://downloads.sourceforge.net/libmng/libmng-2.0.3.tar.xz \
    --continue --directory-prefix=/sources
fi

md5sum -c ${SCRIPTPATH}/md5-libmng &&

tar xf /sources/libmng-2.0.3.tar.xz -C /sources/ &&

cd /sources/libmng-2.0.3 &&

./configure --prefix=/usr --disable-static &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
${log} `basename "$0"` " built" blfs_all &&

make install &&
install -v -m755 -d        /usr/share/doc/libmng-2.0.3 &&
install -v -m644 doc/*.txt /usr/share/doc/libmng-2.0.3 &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
