#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/iptables-1.8.5.tar.bz2
 then
  rm -rf /sources/iptables-1.8.5.tar.bz2
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

wget http://www.netfilter.org/projects/iptables/files/iptables-1.8.5.tar.bz2 \
    --continue --directory-prefix=/sources &&

md5sum -c ${SCRIPTPATH}/md5-iptables &&

tar xf /sources/iptables-1.8.5.tar.bz2 -C /sources/ &&

cd /sources/iptables-1.8.5 &&

./configure --prefix=/usr      \
            --sbindir=/sbin    \
            --disable-nftables \
            --enable-libipq    \
            --with-xtlibdir=/lib/xtables &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
${log} `basename "$0"` " built" blfs_all &&

make install &&
ln -sfv ../../sbin/xtables-legacy-multi /usr/bin/iptables-xml &&

for file in ip4tc ip6tc ipq xtables
do
  mv -v /usr/lib/lib${file}.so.* /lib &&
  ln -sfv ../../lib/$(readlink /usr/lib/lib${file}.so) /usr/lib/lib${file}.so
done
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
