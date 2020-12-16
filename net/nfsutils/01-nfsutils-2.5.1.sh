#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/nfs-utils-2.5.1
 then
  rm -rf /sources/nfs-utils-2.5.1
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download https://www.kernel.org/pub/linux/utils/nfs-utils/2.5.1/nfs-utils-2.5.1.tar.xz \
        /sources


md5sum -c ${SCRIPTPATH}/md5-nfsutils &&

tar xf /sources/nfs-utils-2.5.1.tar.xz -C /sources/ &&

cd /sources/nfs-utils-2.5.1 &&

as_root groupadd -g 99 nogroup &&
as_root useradd -c \"Unprivileged Nobody\" -d /dev/null -g nogroup -s /bin/false -u 99 nobody &&

./configure --prefix=/usr          \
            --sysconfdir=/etc      \
            --sbindir=/sbin        \
            --disable-nfsv4        \
            --disable-gss &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
${log} `basename "$0"` " built" blfs_all &&

as_root make install &&
as_root mv -v /sbin/start-statd /usr/sbin &&
as_root chmod u+w,go+r /sbin/mount.nfs    &&
as_root chown nobody.nogroup /var/lib/nfs &&
cd /usr/src/blfs-systemd-units &&
make install-nfsv4-server &&
make install-nfs-client &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
