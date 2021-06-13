#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/iptables-1.8.7.tar.bz2
 then
  rm -rf /sources/iptables-1.8.7.tar.bz2
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download http://www.netfilter.org/projects/iptables/files/iptables-1.8.7.tar.bz2 \
    /sources &&

md5sum -c ${SCRIPTPATH}/md5-iptables &&

tar xf /sources/iptables-1.8.7.tar.bz2 -C /sources/ &&

cd /sources/iptables-1.8.7 &&

./configure --prefix=/usr      \
            --disable-nftables \
            --enable-libipq &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
${log} `basename "$0"` " built" blfs_all &&

as_root make install &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
