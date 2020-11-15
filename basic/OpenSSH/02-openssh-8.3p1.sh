#!/bin/bash

${log} `basename "$0"` " started" blfs_basic &&
if test -d /sources/openssh-8.3p1
 then
  rm -rf /sources/openssh-8.3p1
fi

tar -xzf /sources/openssh-8.3p1.tar.gz -C /sources/ &&

cd /sources/openssh-8.3p1 &&

./configure --prefix=/usr                     \
            --sysconfdir=/etc/ssh             \
            --with-md5-passwords              \
            --with-privsep-path=/var/lib/sshd &&
${log} `basename "$0"` " configured" blfs_basic &&
make &&
${log} `basename "$0"` " built" blfs_basic &&
as_root make install &&
as_root install -v -m755    contrib/ssh-copy-id /usr/bin     &&

as_root install -v -m644    contrib/ssh-copy-id.1 \
                    /usr/share/man/man1              &&
as_root install -v -m755 -d /usr/share/doc/openssh-8.3p1     &&
as_root install -v -m644    INSTALL LICENCE OVERVIEW README* \
                    /usr/share/doc/openssh-8.3p1 &&

${log} `basename "$0"` " installed" blfs_basic &&

${log} `basename "$0"` " finished" blfs_basic 
