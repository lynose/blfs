#!/bin/bash

${log} `basename "$0"` " started" blfs_basic &&

if test -d /sources/make-ca-1.7
 then
  rm -rf /sources/make-ca-1.7
fi

tar xf /sources/make-ca-1.7.tar.xz -C /sources/ &&

cd /sources/make-ca-1.7 &&




as_root make install &&
as_root install -vdm755 /etc/ssl/local && 
${log} `basename "$0"` " installed" blfs_basic &&

/usr/sbin/make-ca -g &&
${log} `basename "$0"` " installed global ca" blfs_basic &&
systemctl enable update-pki.timer &&
${log} `basename "$0"` " enable update pki" blfs_basic &&
check_and_download http://www.cacert.org/certs/root.crt &&
check_and_download http://www.cacert.org/certs/class3.crt &&
openssl x509 -in root.crt -text -fingerprint -setalias "CAcert Class 1 root" \
        -addtrust serverAuth -addtrust emailProtection -addtrust codeSigning \
        > /etc/ssl/local/CAcert_Class_1_root.pem &&
openssl x509 -in class3.crt -text -fingerprint -setalias "CAcert Class 3 root" \
        -addtrust serverAuth -addtrust emailProtection -addtrust codeSigning \
        > /etc/ssl/local/CAcert_Class_3_root.pem &&
/usr/sbin/make-ca -r -f
${log} `basename "$0"` " add additionl ca certs" blfs_basic &&
${log} `basename "$0"` " finished" blfs_basic
