#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/ldns-1.7.1
 then
  rm -rf /sources/ldns-1.7.1
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download http://www.nlnetlabs.nl/downloads/ldns/ldns-1.7.1.tar.gz \
        /sources


md5sum -c ${SCRIPTPATH}/md5-ldns &&

tar xf /sources/ldns-1.7.1.tar.gz -C /sources/ &&

cd /sources/ldns-1.7.1 &&

./configure --prefix=/usr           \
            --sysconfdir=/etc       \
            --disable-static        \
            --with-drill &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
make doc &&
${log} `basename "$0"` " built" blfs_all &&

as_root make install &&
as_root install -v -m755 -d /usr/share/doc/ldns-1.7.1 &&
as_root install -v -m644 doc/html/* /usr/share/doc/ldns-1.7.1
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
