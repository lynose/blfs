#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/itstool-2.0.6
 then
  rm -rf /sources/itstool-2.0.6
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

wget http://files.itstool.org/itstool/itstool-2.0.6.tar.bz2 \
    --continue --directory-prefix=/sources &&

md5sum -c ${SCRIPTPATH}/md5-itstool &&

tar xf /sources/itstool-2.0.6.tar.bz2 -C /sources/ &&

cd /sources/itstool-2.0.6 &&

PYTHON=/usr/bin/python3 ./configure --prefix=/usr &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
${log} `basename "$0"` " built" blfs_all &&

make install &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
