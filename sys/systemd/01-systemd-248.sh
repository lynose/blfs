#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/systemd-248
 then
  as_root rm -rf /sources/systemd-248
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`
check_and_download https://github.com/systemd/systemd/archive/v248/systemd-248.tar.gz \
    /sources &&
check_and_download http://www.linuxfromscratch.org/patches/blfs/svn/systemd-248-upstream_fixes-3.patch \
    /sources &&
    
md5sum -c ${SCRIPTPATH}/md5-systemd &&

tar xf /sources/systemd-248.tar.gz -C /sources/ &&

cd /sources/systemd-248 &&

patch -Np1 -i ../systemd-248-upstream_fixes-1.patch &&

sed -i 's/GROUP="render"/GROUP="video"/' rules.d/50-udev-default.rules.in &&

mkdir build &&
cd    build &&

meson --prefix=/usr                 \
      --sysconfdir=/etc             \
      --localstatedir=/var          \
      --buildtype=release           \
      -Dblkid=true                  \
      -Ddefault-dnssec=no           \
      -Dfirstboot=false             \
      -Dinstall-tests=false         \
      -Dldconfig=false              \
      -Dman=auto                    \
      -Dsysusers=false              \
      -Drpmmacrosdir=no             \
      -Db_lto=false                 \
      -Dhomed=false                 \
      -Duserdb=false                \
      -Dmode=release                \
      -Dpamconfdir=/etc/pam.d       \
      -Ddocdir=/usr/share/doc/systemd-248 \
      ..                            &&
${log} `basename "$0"` " configured" blfs_all &&

ninja &&
${log} `basename "$0"` " built" blfs_all &&

if [ ${ENABLE_TEST} == true ]
 then
  ninja test &&
  ${log} `basename "$0"` " check succeed" blfs_all ||
  ${log} `basename "$0"` " expected check fail?" blfs_all
fi

as_root ninja install &&

cat >> ./system-session << "EOF" &&
# Begin Systemd addition
    
session  required    pam_loginuid.so
session  optional    pam_systemd.so

# End Systemd addition
EOF

as_root install -vm644 --owner=root ./system-session /etc/pam.d/ &&

cat > ./systemd-user << "EOF" &&
# Begin /etc/pam.d/systemd-user

account  required    pam_access.so
account  include     system-account

session  required    pam_env.so
session  required    pam_limits.so
session  required    pam_unix.so
session  required    pam_loginuid.so
session  optional    pam_keyinit.so force revoke
session  optional    pam_systemd.so

auth     required    pam_deny.so
password required    pam_deny.so

# End /etc/pam.d/systemd-user
EOF

as_root install -vm644 --owner=root  ./systemd-user /etc/pam.d/ &&

${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
