#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/libpwquality-1.4.4
 then
  rm -rf /sources/libpwquality-1.4.4
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download https://github.com/libpwquality/libpwquality/releases/download/libpwquality-1.4.4/libpwquality-1.4.4.tar.bz2 \
    /sources &&

md5sum -c ${SCRIPTPATH}/md5-libpwquality &&

tar xf /sources/libpwquality-1.4.4.tar.bz2 -C /sources/ &&

cd /sources/libpwquality-1.4.4 &&

./configure --prefix=/usr                  \
            --disable-static               \
            --with-securedir=/lib/security \
            --with-python-binary=python3 &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
${log} `basename "$0"` " built" blfs_all &&

as_root make install &&
if [ ! -f /etc/pam.d/system-password.orig ]
 then 
  as_root mv /etc/pam.d/system-password{,.orig} &&
  cat > ./system-password << "EOF" &&
# Begin /etc/pam.d/system-password

# check new passwords for strength (man pam_pwquality)
password  required    pam_pwquality.so   authtok_type=UNIX retry=1 difok=1 \
                                         minlen=8 dcredit=0 ucredit=0 \
                                         lcredit=0 ocredit=0 minclass=1 \
                                         maxrepeat=0 maxsequence=0 \
                                         maxclassrepeat=0 geoscheck=0 \
                                         dictcheck=1 usercheck=1 \
                                         enforcing=1 badwords="" \
                                         dictpath=/lib/cracklib/pw_dict
# use sha512 hash for encryption, use shadow, and use the
# authentication token (chosen password) set by pam_pwquality
# above (or any previous modules)
password  required    pam_unix.so        sha512 shadow use_authtok

# End /etc/pam.d/system-password
EOF
  as_root install -vm644 --owner=root ./system-password /etc/pam.d/system-password
fi
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
