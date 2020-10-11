#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/Linux-PAM-1.4.0
 then
  rm -rf /sources/Linux-PAM-1.4.0
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

wget https://github.com/linux-pam/linux-pam/releases/download/v1.4.0/Linux-PAM-1.4.0.tar.xz \
    --continue --directory-prefix=/sources &&
wget https://github.com/linux-pam/linux-pam/releases/download/v1.4.0/Linux-PAM-1.4.0-docs.tar.xz \
    --continue --directory-prefix=/sources &&
    
    
md5sum -c ${SCRIPTPATH}/md5-Linux-PAM &&

tar xf /sources/Linux-PAM-1.4.0.tar.xz -C /sources/ &&

cd /sources/Linux-PAM-1.4.0 &&

tar -xf ../Linux-PAM-1.4.0-docs.tar.xz --strip-components=1 &&

./configure --prefix=/usr                    \
            --sysconfdir=/etc                \
            --libdir=/usr/lib                \
            --enable-securedir=/lib/security \
            --docdir=/usr/share/doc/Linux-PAM-1.4.0 &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
${log} `basename "$0"` " built" blfs_all &&

install -v -m755 -d /etc/pam.d &&

cat > /etc/pam.d/other << "EOF"
auth     required       pam_deny.so
account  required       pam_deny.so
password required       pam_deny.so
session  required       pam_deny.so
EOF

make check &&
${log} `basename "$0"` " unexpected check succeed" blfs_all
${log} `basename "$0"` " expected check fail?" blfs_all &&
rm -fv /etc/pam.d/other &&


make install &&
chmod -v 4755 /sbin/unix_chkpwd &&

for file in pam pam_misc pamc
do
  mv -v /usr/lib/lib${file}.so.* /lib &&
  ln -sfv ../../lib/$(readlink /usr/lib/lib${file}.so) /usr/lib/lib${file}.so
done

install -vdm755 /etc/pam.d &&
cat > /etc/pam.d/system-account << "EOF" &&
# Begin /etc/pam.d/system-account

account   required    pam_unix.so

# End /etc/pam.d/system-account
EOF

cat > /etc/pam.d/system-auth << "EOF" &&
# Begin /etc/pam.d/system-auth

auth      required    pam_unix.so

# End /etc/pam.d/system-auth
EOF

cat > /etc/pam.d/system-session << "EOF"
# Begin /etc/pam.d/system-session

session   required    pam_unix.so

# End /etc/pam.d/system-session
EOF
cat > /etc/pam.d/system-password << "EOF"
# Begin /etc/pam.d/system-password

# use sha512 hash for encryption, use shadow, and try to use any previously
# defined authentication token (chosen password) set by any prior module
password  required    pam_unix.so       sha512 shadow try_first_pass

# End /etc/pam.d/system-password
EOF

cat > /etc/pam.d/other << "EOF"
# Begin /etc/pam.d/other

auth        required        pam_warn.so
auth        required        pam_deny.so
account     required        pam_warn.so
account     required        pam_deny.so
password    required        pam_warn.so
password    required        pam_deny.so
session     required        pam_warn.so
session     required        pam_deny.so

# End /etc/pam.d/other
EOF

${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
