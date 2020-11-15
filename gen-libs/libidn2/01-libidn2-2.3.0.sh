#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/libidn2-2.3.0
 then
  rm -rf /sources/libidn2-2.3.0
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download https://ftp.gnu.org/gnu/libidn/libidn2-2.3.0.tar.gz \
    /sources &&

md5sum -c ${SCRIPTPATH}/md5-libidn2 &&

tar xf /sources/libidn2-2.3.0.tar.gz -C /sources/ &&

cd /sources/libidn2-2.3.0 &&

./configure --prefix=/usr --disable-static &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
${log} `basename "$0"` " built" blfs_all &&

make check &&
${log} `basename "$0"` " check succeed" blfs_all &&

as_root make install &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
