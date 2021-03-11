#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/systemd-247
 then
  rm -rf /sources/systemd-247
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`
check_and_download https://github.com/systemd/systemd/archive/v247/systemd-247.tar.gz \
    /sources &&
check_and_download http://www.linuxfromscratch.org/patches/blfs/svn/systemd-247-upstream_fixes-2.patch \
    /sources &&
    
md5sum -c ${SCRIPTPATH}/md5-systemd &&

tar xf /sources/systemd-247.tar.gz -C /sources/ &&

cd /sources/systemd-247 &&

patch -Np1 -i ../systemd-247-upstream_fixes-2.patch &&

sed -i 's/GROUP="render"/GROUP="video"/' rules.d/50-udev-default.rules.in &&

mkdir build &&
cd    build &&

meson --prefix=/usr                 \
      -Dblkid=true                  \
      -Dbuildtype=release           \
      -Ddefault-dnssec=no           \
      -Dfirstboot=false             \
      -Dinstall-tests=false         \
      -Dldconfig=false              \
      -Dman=auto                    \
      -Drootprefix=                 \
      -Drootlibdir=/lib             \
      -Dsplit-usr=true              \
      -Dsysusers=false              \
      -Drpmmacrosdir=no             \
      -Db_lto=false                 \
      -Dhomed=false                 \
      -Duserdb=false                \
      -Dmode=release                \
      -Dpamconfdir=/etc/pam.d       \
      -Ddocdir=/usr/share/doc/systemd-247 \
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

as_root mv -v ./system-session /etc/pam.d/system-session &&

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

as_root mv -v ./systemd-user /etc/pam.d/systemd-user &&

${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
