#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/libpcap-1.9.1
 then
  rm -rf /sources/libpcap-1.9.1
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download http://www.tcpdump.org/release/libpcap-1.9.1.tar.gz \
        /sources 
check_and_download http://www.linuxfromscratch.org/patches/blfs/10.0/libpcap-1.9.1-enable_bluetooth-1.patch \
        /sources


md5sum -c ${SCRIPTPATH}/md5-libpcap-1.9.1 &&

tar xf /sources/libpcap-1.9.1.tar.gz -C /sources/ &&

cd /sources/libpcap-1.9.1 &&

patch -Np1 -i ../libpcap-1.9.1-enable_bluetooth-1.patch &&

./configure --prefix=/usr &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
${log} `basename "$0"` " built" blfs_all &&

sed -i '/INSTALL_DATA.*libpcap.a\|RANLIB.*libpcap.a/ s/^/#/' Makefile &&

as_root make install &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
