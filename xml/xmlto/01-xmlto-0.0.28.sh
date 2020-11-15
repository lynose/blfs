#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/xmlto-0.0.28
 then
  rm -rf /sources/xmlto-0.0.28
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download https://releases.pagure.org/xmlto/xmlto-0.0.28.tar.bz2 \
    /sources &&

md5sum -c ${SCRIPTPATH}/md5-xmlto &&

tar xf /sources/xmlto-0.0.28.tar.bz2 -C /sources/ &&

cd /sources/xmlto-0.0.28 &&

LINKS="/usr/bin/links" \
./configure --prefix=/usr &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
${log} `basename "$0"` " built" blfs_all &&

make check &&
${log} `basename "$0"` " check succeed" blfs_all &&

as_root make install &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
