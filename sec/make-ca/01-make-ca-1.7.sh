#!/bin/bash

${log} `basename "$0"` " started" blfs_all &&

if test -d /sources/make-ca-1.7
 then
  as_root rm -rf /sources/make-ca-1.7
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

tar xf /sources/make-ca-1.7.tar.xz -C /sources/ &&

cd /sources/make-ca-1.7 &&

as_root make install &&

if [ ! -d /etc/ssl/local ]
  then
    as_root install -vdm755 /etc/ssl/local
fi
${log} `basename "$0"` " installed" blfs_all &&

as_root /usr/sbin/make-ca -g &&
${log} `basename "$0"` " installed global ca" blfs_all &&
as_root systemctl enable update-pki.timer &&
${log} `basename "$0"` " enable update pki" blfs_all &&

if [ ! -f /etc/ssl/local/CAcert_Class_1_root.pem ]; then
    wget http://www.cacert.org/certs/root.crt &&
    as_root openssl x509 -in root.crt -text -fingerprint -setalias "CAcert Class 1 root" \
        -addtrust serverAuth -addtrust emailProtection -addtrust codeSigning \
        > /etc/ssl/local/CAcert_Class_1_root.pem
fi

if [ ! -f /etc/ssl/local/CAcert_Class_3_root.pem ]; then
    wget http://www.cacert.org/certs/class3.crt &&
    as_root openssl x509 -in class3.crt -text -fingerprint -setalias "CAcert Class 3 root" \
        -addtrust serverAuth -addtrust emailProtection -addtrust codeSigning \
        > /etc/ssl/local/CAcert_Class_3_root.pem
fi
as_root /usr/sbin/make-ca -r -f &&

${log} `basename "$0"` " add additionl ca certs" blfs_all &&
${log} `basename "$0"` " finished" blfs_all
