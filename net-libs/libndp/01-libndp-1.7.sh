#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/libndp-1.7
 then
  rm -rf /sources/libndp-1.7
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download http://libndp.org/files/libndp-1.7.tar.gz \
    /sources &&

md5sum -c ${SCRIPTPATH}/md5-libndp &&

tar xf /sources/libndp-1.7.tar.gz -C /sources/ &&

cd /sources/libndp-1.7 &&

./configure --prefix=/usr        \
            --sysconfdir=/etc    \
            --localstatedir=/var \
            --disable-static  &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
${log} `basename "$0"` " built" blfs_all &&

as_root make install &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
