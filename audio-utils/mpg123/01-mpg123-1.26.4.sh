#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/mpg123-1.26.4
 then
  rm -rf /sources/mpg123-1.26.4
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download https://downloads.sourceforge.net/mpg123/mpg123-1.26.4.tar.bz2 \
    /sources &&


md5sum -c ${SCRIPTPATH}/md5-mpg123 &&

tar xf /sources/mpg123-1.26.4.tar.bz2 -C /sources/ &&

cd /sources/mpg123-1.26.4 &&

./configure --prefix=/usr &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
${log} `basename "$0"` " built" blfs_all &&

as_root make install &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
