#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/Linux-PAM-1.5.1
 then
  rm -rf /sources/Linux-PAM-1.5.1
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download https://github.com/linux-pam/linux-pam/releases/download/v1.5.1/Linux-PAM-1.5.1.tar.xz \
    /sources &&
check_and_download https://github.com/linux-pam/linux-pam/releases/download/v1.5.1/Linux-PAM-1.5.1-docs.tar.xz \
    /sources &&
    
    
md5sum -c ${SCRIPTPATH}/md5-Linux-PAM &&

tar xf /sources/Linux-PAM-1.5.1.tar.xz -C /sources/ &&

cd /sources/Linux-PAM-1.5.1 &&

tar -xf ../Linux-PAM-1.5.1-docs.tar.xz --strip-components=1 &&

./configure --prefix=/usr                    \
            --sysconfdir=/etc                \
            --libdir=/usr/lib                \
            --enable-securedir=/lib/security \
            --docdir=/usr/share/doc/Linux-PAM-1.5.1 &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
${log} `basename "$0"` " built" blfs_all &&

as_root install -v -m755 -d /etc/pam.d &&



if [ ${ENABLE_TEST} == true ]
 then
  cat > ./other << "EOF" &&
auth     required       pam_deny.so
account  required       pam_deny.so
password required       pam_deny.so
session  required       pam_deny.so
EOF
  as_root install -vm644 ./other /etc/pam.d &&
  make check &&
  ${log} `basename "$0"` " check succeed" blfs_all ||
  ${log} `basename "$0"` " expected check fail?" blfs_all
  as_root rm -fv /etc/pam.d/other
fi

as_root make install &&
as_root chmod -v 4755 /sbin/unix_chkpwd &&

as_root install -vdm755 /etc/pam.d &&

cat > /tmp/system-account << "EOF" &&
# Begin /etc/pam.d/system-account

account   required    pam_unix.so

# End /etc/pam.d/system-account
EOF

as_root install -vm644 --owner=root /tmp/system-account /etc/pam.d &&

cat > /tmp/system-auth << "EOF" &&
# Begin /etc/pam.d/system-auth

auth      required    pam_unix.so

# End /etc/pam.d/system-auth
EOF

as_root install -vm644 --owner=root /tmp/system-auth /etc/pam.d &&

cat > /tmp/system-session << "EOF" &&
# Begin /etc/pam.d/system-session

session   required    pam_unix.so

# End /etc/pam.d/system-session
EOF

as_root install -vm644 --owner=root /tmp/system-session /etc/pam.d &&

cat > /tmp/system-password << "EOF" &&
# Begin /etc/pam.d/system-password

# use sha512 hash for encryption, use shadow, and try to use any previously
# defined authentication token (chosen password) set by any prior module
password  required    pam_unix.so       sha512 shadow try_first_pass

# End /etc/pam.d/system-password
EOF

as_root install -vm644 --owner=root /tmp/system-password /etc/pam.d &&

cat > /tmp/other << "EOF" &&
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

as_root install -vm644 --owner=root /tmp/other /etc/pam.d &&

${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
