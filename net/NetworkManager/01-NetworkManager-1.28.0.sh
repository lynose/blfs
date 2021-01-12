#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/NetworkManager-1.28.0
 then
  rm -rf /sources/NetworkManager-1.28.0
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download http://ftp.gnome.org/pub/gnome/sources/NetworkManager/1.26/NetworkManager-1.28.0.tar.xz \
    /sources &&

md5sum -c ${SCRIPTPATH}/md5-NetworkManager &&

tar xf /sources/NetworkManager-1.28.0.tar.xz -C /sources/ &&

cd /sources/NetworkManager-1.28.0 &&

sed -e 's/-qt4/-qt5/'              \
    -e 's/moc_location/host_bins/' \
    -i examples/C/qt/meson.build   &&
sed -e 's/Qt/&5/'                  \
    -i meson.build &&
sed '/initrd/d' -i src/meson.build &&
grep -rl '^#!.*python$' | xargs sed -i '1s/python/&3/' &&
mkdir build &&
cd    build    &&

CXXFLAGS+="-O2 -fPIC"            \
meson --prefix /usr              \
      -Ddocs=true                \
      -Dlibaudit=no              \
      -Dlibpsl=false             \
      -Dnmtui=true               \
      -Dovs=false                \
      -Dppp=false                \
      -Dselinux=false            \
      -Dqt=false                 \
      -Dudev_dir=/lib/udev       \
      -Dsession_tracking=systemd \
      -Dsystemdsystemunitdir=/lib/systemd/system \
      .. &&
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
as_root mv -v /usr/share/doc/NetworkManager{,-1.28.0} &&

cat >> ./NetworkManager.conf << "EOF" &&
[main]
plugins=keyfile
EOF

as_root mv -v ./NetworkManager.conf /etc/NetworkManager/NetworkManager.conf &&

cat > ./conf.d/polkit.conf << "EOF" &&
[main]
auth-polkit=true
EOF

as_root mv -v ./polkit.conf /etc/NetworkManager/conf.d/polkit.conf && 

cat > ./dhcp.conf << "EOF" &&
[main]
dhcp=dhclient
EOF

as_root mv -v ./dhcp.conf /etc/NetworkManager/conf.d/dhcp.conf &&

cat > ./no-dns-update.conf << "EOF" &&
[main]
dns=none
EOF

as_root mv -v ./no-dns-update.conf /etc/NetworkManager/conf.d/no-dns-update.conf &&

as_root_groupadd groupadd -fg 86 netdev &&
as_root_useradd /usr/sbin/usermod -a -G netdev lynose &&


cat > ./org.freedesktop.NetworkManager.rules << "EOF" &&
polkit.addRule(function(action, subject) {
    if (action.id.indexOf("org.freedesktop.NetworkManager.") == 0 && subject.isInGroup("netdev")) {
        return polkit.Result.YES;
    }
});
EOF

as_root mv ./org.freedesktop.NetworkManager.rules /usr/share/polkit-1/rules.d/org.freedesktop.NetworkManager.rules &&

as_root systemctl enable NetworkManager &&
as_root systemctl disable NetworkManager-wait-online &&

${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 