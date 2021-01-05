#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/xapian-core-1.4.16
 then
  rm -rf /sources/xapian-core-1.4.16
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download http://oligarchy.co.uk/xapian/1.4.16/xapian-core-1.4.16.tar.xz \
    /sources &&

md5sum -c ${SCRIPTPATH}/md5-xapian &&

tar xf /sources/xapian-core-1.4.16.tar.xz -C /sources/ &&

cd /sources/xapian-core-1.4.16 &&

./configure --prefix=/usr    \
            --disable-static \
            --docdir=/usr/share/doc/xapian-core-1.4.16 &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
${log} `basename "$0"` " built" blfs_all &&

if [ ${ENABLE_TEST} == true ]
 then
  make check &&
  ${log} `basename "$0"` " check succeed" blfs_all ||
  ${log} `basename "$0"` " expected check fail?" blfs_all
fi

as_root make install &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
