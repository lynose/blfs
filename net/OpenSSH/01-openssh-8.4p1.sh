#!/bin/bash

${log} `basename "$0"` " started" networking &&
if test -d /sources/openssh-8.4p1
 then
  rm -rf /sources/openssh-8.4p1
fi

check_and_download http://ftp.openbsd.org/pub/OpenBSD/OpenSSH/portable/openssh-8.4p1.tar.gz \
        /sources &&

tar -xzf /sources/openssh-8.4p1.tar.gz -C /sources/ &&

cd /sources/openssh-8.4p1 &&

as_root install  -v -m700 -d /var/lib/sshd &&
as_root chown    -v root:sys /var/lib/sshd &&

as_root_groupadd -g 50 sshd        &&
as_root_useradd  -c 'sshd_PrivSep' \
         -d /var/lib/sshd  \
         -g sshd           \
         -s /bin/false     \
         -u 50 sshd

./configure --prefix=/usr                     \
            --sysconfdir=/etc/ssh             \
            --with-md5-passwords              \
            --with-privsep-path=/var/lib/sshd &&
${log} `basename "$0"` " configured" networking &&
make &&
${log} `basename "$0"` " built" networking &&
as_root make install &&
as_root install -v -m755    contrib/ssh-copy-id /usr/bin     &&

as_root install -v -m644    contrib/ssh-copy-id.1 \
                    /usr/share/man/man1              &&
as_root install -v -m755 -d /usr/share/doc/openssh-8.4p1     &&
as_root install -v -m644    INSTALL LICENCE OVERVIEW README* \
                    /usr/share/doc/openssh-8.4p1 &&
as_root echo "PermitRootLogin no" >> /etc/ssh/sshd_config &&

${log} `basename "$0"` " installed" networking &&



${log} `basename "$0"` " finished" networking 
