#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/libcap-2.47
 then
  rm -rf /sources/libcap-2.47
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download https://www.kernel.org/pub/linux/libs/security/linux-privs/libcap2/libcap-2.47.tar.xz \
    /sources &&

md5sum -c ${SCRIPTPATH}/md5-libcap &&

tar xf /sources/libcap-2.47.tar.xz -C /sources/ &&

cd /sources/libcap-2.47 &&

make -C pam_cap &&
${log} `basename "$0"` " built" blfs_all &&

as_root install -v -m755 pam_cap/pam_cap.so /lib/security &&
as_root install -v -m644 pam_cap/capability.conf /etc/security &&

if [ ! -f /etc/pam.d/system-auth.bak ]
 then
  as_root mv -v /etc/pam.d/system-auth{,.bak} &&

  cat > /tmp/system-auth << "EOF" &&
# Begin /etc/pam.d/system-auth

auth      optional    pam_cap.so
EOF
  
  as_root mv -v /tmp/system-auth /etc/pam.d &&
  as_root tail -n +3 /etc/pam.d/system-auth.bak >> /etc/pam.d/system-auth
fi
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
