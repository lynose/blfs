#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/libcap-2.42
 then
  rm -rf /sources/libcap-2.42
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

wget https://www.kernel.org/pub/linux/libs/security/linux-privs/libcap2/libcap-2.42.tar.xz \
    --continue --directory-prefix=/sources &&

md5sum -c ${SCRIPTPATH}/md5-libcap &&

tar xf /sources/libcap-2.42.tar.xz -C /sources/ &&

cd /sources/libcap-2.42 &&

make -C pam_cap &&
${log} `basename "$0"` " built" blfs_all &&

install -v -m755 pam_cap/pam_cap.so /lib/security &&
install -v -m644 pam_cap/capability.conf /etc/security &&

mv -v /etc/pam.d/system-auth{,.bak} &&
cat > /etc/pam.d/system-auth << "EOF" &&
# Begin /etc/pam.d/system-auth

auth      optional    pam_cap.so
EOF
tail -n +3 /etc/pam.d/system-auth.bak >> /etc/pam.d/system-auth &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
