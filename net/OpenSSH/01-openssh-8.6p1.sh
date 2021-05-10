#!/bin/bash

${log} `basename "$0"` " started" blfs_all &&
if test -d /sources/openssh-8.6p1
 then
  as_root rm -rf /sources/openssh-8.6p1
fi

check_and_download http://ftp.openbsd.org/pub/OpenBSD/OpenSSH/portable/openssh-8.6p1.tar.gz \
        /sources &&

tar -xzf /sources/openssh-8.6p1.tar.gz -C /sources/ &&

cd /sources/openssh-8.6p1 &&

as_root install  -v -m700 -d /var/lib/sshd &&
as_root chown    -v root:sys /var/lib/sshd &&

as_root_groupadd groupadd -g 50 sshd        &&
as_root_useradd  useradd -c 'sshd_PrivSep' \
         -d /var/lib/sshd  \
         -g sshd           \
         -s /bin/false     \
         -u 50 sshd &&

./configure --prefix=/usr                     \
            --sysconfdir=/etc/ssh             \
            --with-md5-passwords              \
            --with-privsep-path=/var/lib/sshd &&
${log} `basename "$0"` " configured" blfs_all &&
make &&
${log} `basename "$0"` " built" blfs_all &&
as_root make install &&
as_root install -v -m755    contrib/ssh-copy-id /usr/bin     &&

as_root install -v -m644    contrib/ssh-copy-id.1 \
                    /usr/share/man/man1              &&
as_root install -v -m755 -d /usr/share/doc/openssh-8.6p1     &&
as_root install -v -m644    INSTALL LICENCE OVERVIEW README* \
                    /usr/share/doc/openssh-8.6p1 &&
if [ -f /etc/ssh/sshd_config ]
  then 
    cp /etc/ssh/sshd_config /tmp &&
    echo "PermitRootLogin no" >> /tmp/sshd_config &&
    as_root mv /tmp/sshd_config /etc/ssh/sshd_config 
fi
cd /usr/src/blfs-systemd-units &&
as_root make install-sshd &&
as_root systemctl enable sshd &&
as_root systemctl start sshd &&
${log} `basename "$0"` " installed" blfs_all &&

${log} `basename "$0"` " finished" blfs_all 
