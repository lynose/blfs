#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/udisks-2.9.1
 then
  rm -rf /sources/udisks-2.9.1
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

wget https://github.com/storaged-project/udisks/releases/download/udisks-2.9.1/udisks-2.9.1.tar.bz2 \
    --continue --directory-prefix=/sources &&

md5sum -c ${SCRIPTPATH}/md5-udisks &&

tar xf /sources/udisks-2.9.1.tar.bz2 -C /sources/ &&

cd /sources/udisks-2.9.1 &&

./configure --prefix=/usr        \
            --sysconfdir=/etc    \
            --localstatedir=/var \
            --disable-static &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
${log} `basename "$0"` " built" blfs_all &&

make check &&
${log} `basename "$0"` " unexpected check succeed" blfs_all
${log} `basename "$0"` " expected check fail?" blfs_all &&

make install &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
