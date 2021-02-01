#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/nss-3.61
 then
  rm -rf /sources/nss-3.61
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download https://archive.mozilla.org/pub/security/nss/releases/NSS_3_61_RTM/src/nss-3.61.tar.gz \
    /sources &&
    
check_and_download http://www.linuxfromscratch.org/patches/blfs/svn/nss-3.61-standalone-1.patch \
    /sources &&

md5sum -c ${SCRIPTPATH}/md5-nss &&

tar xf /sources/nss-3.61.tar.gz -C /sources/ &&

cd /sources/nss-3.61 &&

patch -Np1 -i ../nss-3.61-standalone-1.patch &&

cd nss &&
${log} `basename "$0"` " configured" blfs_all &&

make -j1 BUILD_OPT=1                  \
  NSPR_INCLUDE_DIR=/usr/include/nspr  \
  USE_SYSTEM_ZLIB=1                   \
  ZLIB_LIBS=-lz                       \
  NSS_ENABLE_WERROR=0                 \
  $([ $(uname -m) = x86_64 ] && echo USE_64=1) \
  $([ -f /usr/include/sqlite3.h ] && echo NSS_USE_SYSTEM_SQLITE=1) &&
${log} `basename "$0"` " built" blfs_all &&

if [ ${ENABLE_TEST} == true ]
 then
  cd tests &&
  HOST=localhost DOMSUF=localdomain ./all.sh &&
  ${log} `basename "$0"` " check succeed" blfs_all ||
  ${log} `basename "$0"` " expected check fail?" blfs_all
  cd ../
fi

cd ../dist                                                          &&

as_root install -v -m755 Linux*/lib/*.so              /usr/lib              &&
as_root install -v -m644 Linux*/lib/{*.chk,libcrmf.a} /usr/lib              &&

as_root install -v -m755 -d                           /usr/include/nss      &&
as_root cp -v -RL {public,private}/nss/*              /usr/include/nss      &&
as_root chmod -v 644                                  /usr/include/nss/*    &&

as_root install -v -m755 Linux*/bin/{certutil,nss-config,pk12util} /usr/bin &&

as_root install -v -m644 Linux*/lib/pkgconfig/nss.pc  /usr/lib/pkgconfig &&

as_root ln -sfv ./pkcs11/p11-kit-trust.so /usr/lib/libnssckbi.so &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
