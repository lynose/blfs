#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/gavl-1.4.0
 then
  rm -rf /sources/gavl-1.4.0
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`
if [ ! -f /sources/gavl-1.4.0.tar.gz ];  
 then
  wget https://downloads.sourceforge.net/gmerlin/gavl-1.4.0.tar.gz \
    --continue --directory-prefix=/sources
fi

md5sum -c ${SCRIPTPATH}/md5-gavl &&

tar xf /sources/gavl-1.4.0.tar.gz -C /sources/ &&

cd /sources/gavl-1.4.0 &&

LIBS=-lm                      \
./configure --prefix=/usr     \
            --docdir=/usr/share/doc/gavl-1.4.0  &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
${log} `basename "$0"` " built" blfs_all &&

make install &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
