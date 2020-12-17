#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/pm-utils-1.4.1
 then
  rm -rf /sources/pm-utils-1.4.1
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download https://pm-utils.freedesktop.org/releases/pm-utils-1.4.1.tar.gz \
        /sources &&


md5sum -c ${SCRIPTPATH}/md5-pm-utils &&

tar xf /sources/pm-utils-1.4.1.tar.gz -C /sources/ &&

cd /sources/pm-utils-1.4.1 &&

./configure --prefix=/usr     \
            --sysconfdir=/etc \
            --docdir=/usr/share/doc/pm-utils-1.4.1 &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
${log} `basename "$0"` " built" blfs_all &&


as_root make install &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
