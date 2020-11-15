#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
# if test -d /sources/plasma
#  then
#   rm -rf /sources/plasma
# fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`
mkdir /sources/plasma &&
cp -u ${SCRIPTPATH}/md5-plasma /sources/plasma &&
cd /sources/plasma &&


url=http://download.kde.org/stable/plasma/5.19.4/ &&
wget --continue -r -nH -nd -A '*.xz' -np $url &&
md5sum --ignore-missing -c ./md5-plasma &&


while read -r line; do

    # Get the file name, ignoring comments and blank lines
    if $(echo $line | grep -E -q '^ *$|^#' ); then continue; fi
    file=$(echo $line | cut -d" " -f2)

    ${log} `basename "$0"` " ======================================" blfs_all &&
    pkg=$(echo $file|sed 's|^.*/||')          # Remove directory
    packagedir=$(echo $pkg|sed 's|\.tar.*||') # Package directory


    tar -xf $file &&
    pushd $packagedir &&

        # Fix some build issues when generating some configuration files
        case $name in
            plasma-workspace)
            sed -i '/set.HAVE_X11/a set(X11_FOUND 1)' CMakeLists.txt
            ;;
        
            khotkeys)
            sed -i '/X11Extras/a set(X11_FOUND 1)' CMakeLists.txt
            ;;
        
            plasma-desktop)
            sed -i '/X11.h)/i set(X11_FOUND 1)' CMakeLists.txt
            ;;
        esac

        mkdir build &&
        cd    build &&

      
        cmake -DCMAKE_INSTALL_PREFIX=$KF5_PREFIX \
            -DCMAKE_BUILD_TYPE=Release         \
            -DBUILD_TESTING=OFF                \
            -Wno-dev .. &&
        ${log} `basename "$0"` " configured $packagedir" blfs_all &&
        make &&
        ${log} `basename "$0"` " built $packagedir" blfs_all &&
        as_root make install &&
        ${log} `basename "$0"` " installed $packagedir" blfs_all &&
        ${log} `basename "$0"` " ======================================" blfs_all
    popd

#  as_root rm -rf $packagedir &&
  as_root /sbin/ldconfig
  

done < md5-plasma

as_root install -dvm 755 /usr/share/xsessions              &&
cd /usr/share/xsessions/                                   &&
[ -e plasma.desktop ]                                      ||
as_root ln -sfv $KF5_PREFIX/share/xsessions/plasma.desktop &&
as_root install -dvm 755 /usr/share/wayland-sessions       &&
cd /usr/share/wayland-sessions/                            &&
[ -e plasmawayland.desktop ]                               ||
as_root ln -sfv $KF5_PREFIX/share/wayland-sessions/plasmawayland.desktop

as_root rm -f $XORG_PREFIX/bin/xkeystone &&

as_root cat > /etc/pam.d/kde << "EOF" 
# Begin /etc/pam.d/kde

auth     requisite      pam_nologin.so
auth     required       pam_env.so

auth     required       pam_succeed_if.so uid >= 1000 quiet
auth     include        system-auth

account  include        system-account
password include        system-password
session  include        system-session

# End /etc/pam.d/kde
EOF

as_root cat > /etc/pam.d/kde-np << "EOF" 
# Begin /etc/pam.d/kde-np

auth     requisite      pam_nologin.so
auth     required       pam_env.so

auth     required       pam_succeed_if.so uid >= 1000 quiet
auth     required       pam_permit.so

account  include        system-account
password include        system-password
session  include        system-session

# End /etc/pam.d/kde-np
EOF

as_root cat > /etc/pam.d/kscreensaver << "EOF"
# Begin /etc/pam.d/kscreensaver

auth    include system-auth
account include system-account

# End /etc/pam.d/kscreensaver
EOF

as_root cat > ~/.xinitrc << "EOF"
dbus-launch --exit-with-session $KF5_PREFIX/bin/startplasma-x11
EOF

${log} `basename "$0"` " finished" blfs_all 
