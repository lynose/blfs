#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/cyrus-sasl-2.1.27
 then
  rm -rf /sources/cyrus-sasl-2.1.27
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download https://github.com/cyrusimap/cyrus-sasl/releases/download/cyrus-sasl-2.1.27/cyrus-sasl-2.1.27.tar.gz \
        /sources
check_and_download http://www.linuxfromscratch.org/patches/blfs/10.0/cyrus-sasl-2.1.27-doc_fixes-1.patch \
        /sources

md5sum -c ${SCRIPTPATH}/md5-cyrus-sasl &&

tar xf /sources/cyrus-sasl-2.1.27.tar.gz -C /sources/ &&

cd /sources/cyrus-sasl-2.1.27 &&

patch -Np1 -i ../cyrus-sasl-2.1.27-doc_fixes-1.patch &&

./configure --prefix=/usr        \
            --sysconfdir=/etc    \
            --enable-auth-sasldb \
            --with-dbpath=/var/lib/sasl/sasldb2 \
            --with-saslauthd=/var/run/saslauthd &&
${log} `basename "$0"` " configured" blfs_all &&

make -j1 &&
${log} `basename "$0"` " built" blfs_all &&

as_root make install &&
as_root install -v -dm755                          /usr/share/doc/cyrus-sasl-2.1.27/html &&
as_root install -v -m644  saslauthd/LDAP_SASLAUTHD /usr/share/doc/cyrus-sasl-2.1.27      &&
as_root install -v -m644  doc/legacy/*.html        /usr/share/doc/cyrus-sasl-2.1.27/html &&
as_root install -v -dm700 /var/lib/sasl &&

cd /usr/src/blfs-systemd-units &&
as_root make install-saslauthd &&

${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
