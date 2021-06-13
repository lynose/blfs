#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/p11-kit-0.24.0
 then
  as_root rm -rf /sources/p11-kit-0.24.0
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download https://github.com/p11-glue/p11-kit/releases/download/0.24.0/p11-kit-0.24.0.tar.xz \
    /sources &&

md5sum -c ${SCRIPTPATH}/md5-p11-kit &&

tar xf /sources/p11-kit-0.24.0.tar.xz -C /sources/ &&

cd /sources/p11-kit-0.24.0 &&

sed '20,$ d' -i trust/trust-extract-compat &&
cat >> trust/trust-extract-compat << "EOF" &&
# Copy existing anchor modifications to /etc/ssl/local
/usr/libexec/make-ca/copy-trust-modifications

# Generate a new trust store
/usr/sbin/make-ca -f -g
EOF

mkdir p11-build &&
cd    p11-build &&

meson --prefix=/usr       \
      --buildtype=release \
      -Dtrust_paths=/etc/pki/anchors &&
${log} `basename "$0"` " configured" blfs_all &&

ninja &&
${log} `basename "$0"` " built" blfs_all &&

if [ ${ENABLE_TEST} == true ]
 then
  ninja test &&
  ${log} `basename "$0"` " check succeed" blfs_all ||
  ${log} `basename "$0"` " expected check fail?" blfs_all
fi

as_root ninja install &&
as_root ln -sfv /usr/libexec/p11-kit/trust-extract-compat \
        /usr/bin/update-ca-certificates &&
as_root ln -sfv ./pkcs11/p11-kit-trust.so /usr/lib/libnssckbi.so &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
