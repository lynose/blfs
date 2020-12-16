#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/rsync-3.2.3
 then
  rm -rf /sources/rsync-3.2.3
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download https://www.samba.org/ftp/rsync/src/rsync-3.2.3.tar.gz \
        /sources


md5sum -c ${SCRIPTPATH}/md5-rsync &&

tar xf /sources/rsync-3.2.3.tar.gz -C /sources/ &&

as_root groupadd -g 48 rsyncd &&
as_root useradd -c \"rsyncd Daemon\" -d /home/rsync -g rsyncd -s /bin/false -u 48 rsyncd &&

cd /sources/rsync-3.2.3 &&

./configure --prefix=/usr    \
            --disable-lz4    \
            --disable-xxhash \
            --without-included-zlib &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
doxygen &&
${log} `basename "$0"` " built" blfs_all &&

if [ ${ENABLE_TEST} == true ]
 then
  make check &&
  ${log} `basename "$0"` " unexpected check succeed" blfs_all
  ${log} `basename "$0"` " expected check fail?" blfs_all
fi

as_root make install &&
as_root install -v -m755 -d          /usr/share/doc/rsync-3.2.3/api &&
as_root install -v -m644 dox/html/*  /usr/share/doc/rsync-3.2.3/api &&

cat > ./rsyncd.conf << "EOF" &&
# This is a basic rsync configuration file
# It exports a single module without user authentication.

motd file = /home/rsync/welcome.msg
use chroot = yes

[localhost]
    path = /home/rsync
    comment = Default rsync module
    read only = yes
    list = yes
    uid = rsyncd
    gid = rsyncd

EOF
as_root mv -v ./rsyncd.conf /etc/rsyncd.conf &&
cd /usr/src/blfs-systemd-units &&
as_root make install-rsyncd &&

${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
