#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/nfs-utils-2.5.4
 then
  rm -rf /sources/nfs-utils-2.5.4
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download https://www.kernel.org/pub/linux/utils/nfs-utils/2.5.4/nfs-utils-2.5.4.tar.xz \
        /sources


md5sum -c ${SCRIPTPATH}/md5-nfsutils &&

tar xf /sources/nfs-utils-2.5.4.tar.xz -C /sources/ &&

cd /sources/nfs-utils-2.5.4 &&

as_root_groupadd groupadd -g 99 nogroup &&
as_root_useradd useradd -c \"Unprivileged_Nobody\" -d /dev/null -g nogroup -s /bin/false -u 99 nobody &&

./configure --prefix=/usr          \
            --sysconfdir=/etc      \
            --sbindir=/sbin        \
            --disable-nfsv4        \
            --disable-gss &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
${log} `basename "$0"` " built" blfs_all &&

as_root make install                      &&
as_root chmod u+w,go+r /sbin/mount.nfs    &&
as_root chown nobody.nogroup /var/lib/nfs &&
cd /usr/src/blfs-systemd-units &&
#as_root make install-nfsv4-server &&
as_root make install-nfs-server &&
as_root make install-nfs-client &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
