#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/nss-3.55
 then
  rm -rf /sources/nss-3.55
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

wget https://archive.mozilla.org/pub/security/nss/releases/NSS_3_55_RTM/src/nss-3.55.tar.gz \
    --continue --directory-prefix=/sources &&
    
wget http://www.linuxfromscratch.org/patches/blfs/10.0/nss-3.55-standalone-1.patch \
    --continue --directory-prefix=/sources &&

md5sum -c ${SCRIPTPATH}/md5-nss &&

tar xf /sources/nss-3.55.tar.gz -C /sources/ &&

cd /sources/nss-3.55 &&

patch -Np1 -i ../nss-3.55-standalone-1.patch &&

cd nss &&
${log} `basename "$0"` " configured" blfs_all &&

make BUILD_OPT=1                      \
  NSPR_INCLUDE_DIR=/usr/include/nspr  \
  USE_SYSTEM_ZLIB=1                   \
  ZLIB_LIBS=-lz                       \
  NSS_ENABLE_WERROR=0                 \
  $([ $(uname -m) = x86_64 ] && echo USE_64=1) \
  $([ -f /usr/include/sqlite3.h ] && echo NSS_USE_SYSTEM_SQLITE=1) &&
${log} `basename "$0"` " built" blfs_all &&

# cd tests &&
# HOST=localhost DOMSUF=localdomain ./all.sh &&
# cd ../ &&
# ${log} `basename "$0"` " unexpected check succeed" blfs_all
# ${log} `basename "$0"` " expected check fail?" blfs_all &&

cd ../dist                                                          &&

install -v -m755 Linux*/lib/*.so              /usr/lib              &&
install -v -m644 Linux*/lib/{*.chk,libcrmf.a} /usr/lib              &&

install -v -m755 -d                           /usr/include/nss      &&
cp -v -RL {public,private}/nss/*              /usr/include/nss      &&
chmod -v 644                                  /usr/include/nss/*    &&

install -v -m755 Linux*/bin/{certutil,nss-config,pk12util} /usr/bin &&

install -v -m644 Linux*/lib/pkgconfig/nss.pc  /usr/lib/pkgconfig &&

ln -sfv ./pkcs11/p11-kit-trust.so /usr/lib/libnssckbi.so &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
