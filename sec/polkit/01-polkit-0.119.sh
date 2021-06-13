#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/polkit-0.119
 then
  rm -rf /sources/polkit-0.119
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download https://www.freedesktop.org/software/polkit/releases/polkit-0.119.tar.gz \
    /sources &&

md5sum -c ${SCRIPTPATH}/md5-polkit &&

tar xf /sources/polkit-0.119.tar.gz -C /sources/ &&

cd /sources/polkit-0.119 &&

as_root_groupadd groupadd -fg 27 polkitd &&
as_root_useradd useradd -c \"PolicyKit_Daemon_Owner\" -d /etc/polkit-1 -u 27 \
        -g polkitd -s /bin/false polkitd &&

./configure --prefix=/usr        \
            --sysconfdir=/etc    \
            --localstatedir=/var \
            --disable-static     \
            --enable-gtk-doc     \
            --with-os-type=LFS   &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
${log} `basename "$0"` " built" blfs_all &&

as_root make install &&

cat > ./polkit-1 << "EOF" &&
# Begin /etc/pam.d/polkit-1

auth     include        system-auth
account  include        system-account
password include        system-password
session  include        system-session

# End /etc/pam.d/polkit-1
EOF

as_root install -vm644 --owner=root ./polkit-1 /etc/pam.d/ &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
