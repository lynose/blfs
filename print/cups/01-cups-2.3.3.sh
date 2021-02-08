#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/cups-2.3.3
 then
  rm -rf /sources/cups-2.3.3
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download https://github.com/apple/cups/releases/download/v2.3.3/cups-2.3.3-source.tar.gz \
    /sources &&

md5sum -c ${SCRIPTPATH}/md5-cups &&

tar xf /sources/cups-2.3.3-source.tar.gz -C /sources/ &&

cd /sources/cups-2.3.3 &&

as_root_useradd useradd -c \"Print_Service_User\" -d /var/spool/cups -g lp -s /bin/false -u 9 lp &&

as_root_groupadd groupadd -g 19 lpadmin &&

sed -i '/stat.h/a #include <asm-generic/ioctls.h>' tools/ipptool.c   &&

CC=gcc CXX=g++ \
./configure --libdir=/usr/lib            \
            --with-rcdir=/tmp/cupsinit   \
            --with-system-groups=lpadmin \
            --with-docdir=/usr/share/cups/doc-2.3.3 &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
${log} `basename "$0"` " built" blfs_all &&

 LC_ALL=C make -k check &&
${log} `basename "$0"` " check succeed" blfs_all ||
${log} `basename "$0"` " expected check fail?" blfs_all &&

as_root make install &&
rm -rf /tmp/cupsinit &&
ln -svnf ../cups/doc-2.3.3 /usr/share/doc/cups-2.3.3 &&
echo "ServerName /run/cups/cups.sock" > /etc/cups/client.conf &&
gtk-update-icon-cache -qtf /usr/share/icons/hicolor &&
as_root cat > /etc/pam.d/cups << "EOF"
# Begin /etc/pam.d/cups

auth    include system-auth
account include system-account
session include system-session

# End /etc/pam.d/cups
EOF
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
