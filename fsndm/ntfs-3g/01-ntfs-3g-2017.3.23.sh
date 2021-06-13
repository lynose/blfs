#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/ntfs-3g_ntfsprogs-2017.3.23
 then
  as_root rm -rf /sources/ntfs-3g_ntfsprogs-2017.3.23
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download https://tuxera.com/opensource/ntfs-3g_ntfsprogs-2017.3.23.tgz \
        /sources &&


md5sum -c ${SCRIPTPATH}/md5-ntfs-3g &&

tar xf /sources/ntfs-3g_ntfsprogs-2017.3.23.tgz -C /sources/ &&

cd /sources/ntfs-3g_ntfsprogs-2017.3.23 &&

./configure --prefix=/usr        \
            --disable-static     \
            --with-fuse=internal \
            --docdir=/usr/share/doc/ntfs-3g-2017.3.23 &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
${log} `basename "$0"` " built" blfs_all &&

as_root make install &&
as_root ln -sv ../bin/ntfs-3g /usr/sbin/mount.ntfs &&
as_root ln -sv ntfs-3g.8 /usr/share/man/man8/mount.ntfs.8 &&
as_root chmod -v 4755 /usr/bin/ntfs-3g &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
