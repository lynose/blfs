#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/rest-0.8.1
 then
  rm -rf /sources/rest-0.8.1
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download http://ftp.gnome.org/pub/gnome/sources/rest/0.8/rest-0.8.1.tar.xz \
    /sources &&

md5sum -c ${SCRIPTPATH}/md5-rest &&

tar xf /sources/rest-0.8.1.tar.xz -C /sources/ &&

cd /sources/rest-0.8.1 &&

./configure --prefix=/usr \
    --with-ca-certificates=/etc/pki/tls/certs/ca-bundle.crt &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
${log} `basename "$0"` " built" blfs_all &&

make check &&
${log} `basename "$0"` " unexpected check succeed" blfs_all
${log} `basename "$0"` " expected check fail?" blfs_all &&

as_root make install &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
