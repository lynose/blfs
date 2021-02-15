#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/dosfstools-4.2
 then
  rm -rf /sources/dosfstools-4.2
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download https://github.com/dosfstools/dosfstools/releases/download/v4.2/dosfstools-4.2.tar.gz \
    /sources &&

md5sum -c ${SCRIPTPATH}/md5-dosfstools &&

tar xf /sources/dosfstools-4.2.tar.xz -C /sources/ &&

cd /sources/dosfstools-4.2 &&



./configure --prefix=/               \
            --enable-compat-symlinks \
            --mandir=/usr/share/man  \
            --docdir=/usr/share/doc/dosfstools-4.2 &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
${log} `basename "$0"` " built" blfs_all &&

as_root make install &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
