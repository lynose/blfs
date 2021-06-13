#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/rpcbind-1.2.6
 then
  as_root rm -rf /sources/rpcbind-1.2.6
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download https://downloads.sourceforge.net/rpcbind/rpcbind-1.2.6.tar.bz2 \
        /sources

check_and_download https://www.linuxfromscratch.org/patches/blfs/svn/rpcbind-1.2.6-vulnerability_fixes-1.patch \
        /sources
        
md5sum -c ${SCRIPTPATH}/md5-rpcbind &&

tar xf /sources/rpcbind-1.2.6.tar.bz2 -C /sources/ &&

as_root_groupadd groupadd -g 28 rpc &&
as_root_useradd useradd -c \"RPC_Bind_Daemon_Owner\" -d /dev/null -g rpc -s /bin/false -u 28 rpc &&

cd /sources/rpcbind-1.2.6 &&

sed -i "/servname/s:rpcbind:sunrpc:" src/rpcbind.c &&

patch -Np1 -i ../rpcbind-1.2.6-vulnerability_fixes-1.patch &&

./configure --prefix=/usr       \
            --bindir=/usr/sbin      \
            --enable-warmstarts \
            --with-rpcuser=rpc &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
${log} `basename "$0"` " built" blfs_all &&

as_root make install &&

cd /usr/src/blfs-systemd-units &&
as_root make install-rpcbind &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
