#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/p11-kit-0.23.20
 then
  rm -rf /sources/p11-kit-0.23.20
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download https://github.com/p11-glue/p11-kit/releases/download/0.23.20/p11-kit-0.23.20.tar.xz \
    /sources &&

md5sum -c ${SCRIPTPATH}/md5-p11-kit &&

tar xf /sources/p11-kit-0.23.20.tar.xz -C /sources/ &&

cd /sources/p11-kit-0.23.20 &&

sed '20,$ d' -i trust/trust-extract-compat.in &&
cat >> trust/trust-extract-compat.in << "EOF"
# Copy existing anchor modifications to /etc/ssl/local
/usr/libexec/make-ca/copy-trust-modifications

# Generate a new trust store
/usr/sbin/make-ca -f -g
EOF

./configure --prefix=/usr     \
            --sysconfdir=/etc \
            --with-trust-paths=/etc/pki/anchors &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
${log} `basename "$0"` " built" blfs_all &&

make check &&
${log} `basename "$0"` " unexpected check succeed" blfs_all
${log} `basename "$0"` " expected check fail?" blfs_all &&

as_root make install &&
ln -sfv /usr/libexec/p11-kit/trust-extract-compat \
        /usr/bin/update-ca-certificates &&
ln -sfv ./pkcs11/p11-kit-trust.so /usr/lib/libnssckbi.so &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
