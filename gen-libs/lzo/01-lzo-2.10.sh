#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/lzo-2.10
 then
  rm -rf /sources/lzo-2.10
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download http://www.oberhumer.com/opensource/lzo/download/lzo-2.10.tar.gz \
    /sources &&

md5sum -c ${SCRIPTPATH}/md5-lzo &&

tar xf /sources/lzo-2.10.tar.gz -C /sources/ &&

cd /sources/lzo-2.10 &&

./configure --prefix=/usr                    \
            --enable-shared                  \
            --disable-static                 \
            --docdir=/usr/share/doc/lzo-2.10  &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
${log} `basename "$0"` " built" blfs_all &&

make check &&
make test &&
${log} `basename "$0"` " check succeed" blfs_all &&

as_root make install &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
