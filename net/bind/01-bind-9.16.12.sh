#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/bind-9.16.12
 then
  rm -rf /sources/bind-9.16.12
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download ftp://ftp.isc.org/isc/bind9/9.16.12/bind-9.16.12.tar.xz \
        /sources


md5sum -c ${SCRIPTPATH}/md5-bind &&

tar xf /sources/bind-9.16.12.tar.xz -C /sources/ &&

cd /sources/bind-9.16.12 &&

as_root pip3 install ply &&

./configure --prefix=/usr           \
            --sysconfdir=/etc       \
            --localstatedir=/var    \
            --mandir=/usr/share/man \
            --with-libtool          \
            --with-libidn2          \
            --disable-static &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
${log} `basename "$0"` " built" blfs_all &&

if [ ${ENABLE_TEST} == true ]
 then
  bin/tests/system/ifconfig.sh up &&
  make -k check &&
  ${log} `basename "$0"` " check succeed" blfs_all ||
  ${log} `basename "$0"` " expected check fail?" blfs_all
  bin/tests/system/ifconfig.sh down
fi

as_root make install &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
