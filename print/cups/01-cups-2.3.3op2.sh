#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/cups-2.3.3op2
 then
  as_root rm -rf /sources/cups-2.3.3op2
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download https://github.com/apple/cups/releases/download/v2.3.3op2/cups-2.3.3op2-source.tar.gz \
    /sources &&

md5sum -c ${SCRIPTPATH}/md5-cups &&

tar xf /sources/cups-2.3.3op2-source.tar.gz -C /sources/ &&

cd /sources/cups-2.3.3op2 &&

as_root_useradd useradd -c \"Print_Service_User\" -d /var/spool/cups -g lp -s /bin/false -u 9 lp &&

as_root_groupadd groupadd -g 19 lpadmin &&

if [ $EUID != 0 ]
 then
    as_root usermod -a -G lpadmin $USER
fi

sed -e "s/-Wno-format-truncation//" \
    -i configure \
    -i config-scripts/cups-compiler.m4 &&

./configure --libdir=/usr/lib            \
            --with-system-groups=lpadmin \
            --enable-libpaper            \
            --with-docdir=/usr/share/cups/doc-2.3.3op2 &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
${log} `basename "$0"` " built" blfs_all &&

if [ ${ENABLE_TEST} == true ]
 then
    LC_ALL=C make -k check &&
    ${log} `basename "$0"` " check succeed" blfs_all ||
    ${log} `basename "$0"` " check failed!" blfs_all
fi

as_root make install &&
as_root ln -svnf ../cups/doc-2.3.3op2 /usr/share/doc/cups-2.3.3op2 &&
echo "ServerName /run/cups/cups.sock" > /tmp/client.conf &&
as_root install -vm644 --owner=root /tmp/client.conf /etc/cups/client.conf &&
as_root gtk-update-icon-cache -qtf /usr/share/icons/hicolor &&


cat > /tmp/cups << "EOF" &&
# Begin /etc/pam.d/cups

auth    include system-auth
account include system-account
session include system-session

# End /etc/pam.d/cups
EOF

as_root install -vm644 --owner=root /tmp/cups /etc/pam.d/ &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
