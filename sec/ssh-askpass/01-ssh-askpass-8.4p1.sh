#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/openssh-8.4p1
 then
  as_root rm -rf /sources/openssh-8.4p1
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download http://ftp.openbsd.org/pub/OpenBSD/OpenSSH/portable/openssh-8.4p1.tar.gz \
        /sources &&


md5sum -c ${SCRIPTPATH}/md5-ssh-askpass &&

tar xf /sources/openssh-8.4p1.tar.gz -C /sources/ &&

cd /sources/openssh-8.4p1 &&

cd contrib &&
${log} `basename "$0"` " configured" blfs_all &&

make gnome-ssh-askpass2 &&
${log} `basename "$0"` " built" blfs_all &&


as_root install -v -d -m755 /usr/libexec/openssh/contrib  &&
as_root install -v -m755    gnome-ssh-askpass2 \
                    /usr/libexec/openssh/contrib  &&
as_root ln -sv -f contrib/gnome-ssh-askpass2 \
                    /usr/libexec/openssh/ssh-askpass &&

cp /etc/sudo.conf /tmp &&
cat >> /tmp/sudo.conf << "EOF" &&
# Path to askpass helper program
Path askpass /usr/libexec/openssh/ssh-askpass
EOF
as_root cp /tmp/sudo.conf /etc &&
as_root chown root:root /etc/sudo.conf &&
as_root chmod -v 0644 /etc/sudo.conf &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
