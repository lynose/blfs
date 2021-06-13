#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/bind-9.16.16
 then
  rm -rf /sources/bind-9.16.16
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download ftp://ftp.isc.org/isc/bind9/9.16.16/bind-9.16.16.tar.xz \
        /sources

md5sum -c ${SCRIPTPATH}/md5-bind &&

tar xf /sources/bind-9.16.16.tar.xz -C /sources/ &&

cd /sources/bind-9.16.16 &&

./configure --prefix=/usr --without-python &&
${log} `basename "$0"` " configured" blfs_all &&

make -C lib/dns    &&
make -C lib/isc    &&
make -C lib/bind9  &&
make -C lib/isccfg &&
make -C lib/irs    &&
make -C bin/dig    &&
make -C doc &&
${log} `basename "$0"` " built" blfs_all &&

as_root make -C bin/dig install &&
as_root cp -v doc/man/{dig.1,host.1,nslookup.1} /usr/share/man/man1 &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
