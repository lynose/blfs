#!/bin/bash

${log} `basename "$0"` " started" target &&
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
${log} `basename "$0"` " configured" target &&
make &&
${log} `basename "$0"` " built" target &&
make install &&
install -v -m755    contrib/ssh-copy-id /usr/bin     &&

install -v -m644    contrib/ssh-copy-id.1 \
                    /usr/share/man/man1              &&
install -v -m755 -d /usr/share/doc/openssh-8.3p1     &&
install -v -m644    INSTALL LICENCE OVERVIEW README* \
                    /usr/share/doc/openssh-8.3p1 &&

${log} `basename "$0"` " installed" target &&



${log} `basename "$0"` " finished" target 
