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

./configure --prefix=/usr                     \
            --sysconfdir=/etc/ssh             \
            --with-md5-passwords              \
            --with-privsep-path=/var/lib/sshd \
            --with-libedit                    \
            --with-kerberos5=/usr             \
            --with-xauth=/usr/bin/xauth       \
            --with-pam &&
${log} `basename "$0"` " configured" blfs_all &&
make &&

if [ ${ENABLE_TEST} == true ]
 then
  make -j1 test &&
  ${log} `basename "$0"` " check succeed" blfs_all ||
  ${log} `basename "$0"` " expected check fail?" blfs_all
fi

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
    echo "UsePAM yes" >> /tmp/sshd_config &&
    as_root mv /tmp/sshd_config /etc/ssh/sshd_config 
fi
as_root cp /etc/pam.d/login /tmp &&
sed 's@d/login@d/sshd@g' /tmp/login > /tmp/sshd &&
as_root mv /tmp/sshd /etc/pam.d/sshd &&
as_root chmod 644 /etc/pam.d/sshd &&

${log} `basename "$0"` " installed" blfs_all &&

${log} `basename "$0"` " finished" blfs_all 
