#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/NetworkManager-1.26.0
 then
  rm -rf /sources/NetworkManager-1.26.0
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download http://ftp.gnome.org/pub/gnome/sources/NetworkManager/1.26/NetworkManager-1.26.0.tar.xz \
    /sources &&

md5sum -c ${SCRIPTPATH}/md5-NetworkManager &&

tar xf /sources/NetworkManager-1.26.0.tar.xz -C /sources/ &&

cd /sources/NetworkManager-1.26.0 &&

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
      -Djson_validation=false    \
      -Dlibaudit=no              \
      -Dlibpsl=false             \
      -Dnmtui=false               \
      -Dovs=false                \
      -Dppp=false                \
      -Dselinux=false            \
      -Dqt=false                 \
      -Dudev_dir=/lib/udev       \
      -Dsession_tracking=systemd \
      -Dmodem_manager=false      \
      -Dsystemdsystemunitdir=/lib/systemd/system \
      .. &&
${log} `basename "$0"` " configured" blfs_all &&

ninja &&
${log} `basename "$0"` " built" blfs_all &&

as_root ninja install &&
as_root mv -v /usr/share/doc/NetworkManager{,-1.26.0} &&

as_root cat >> /etc/NetworkManager/NetworkManager.conf << "EOF"
[main]
plugins=keyfile
EOF

as_root cat > /etc/NetworkManager/conf.d/polkit.conf << "EOF"
[main]
auth-polkit=true
EOF

as_root cat > /etc/NetworkManager/conf.d/dhcp.conf << "EOF"
[main]
dhcp=dhclient
EOF

as_root cat > /etc/NetworkManager/conf.d/no-dns-update.conf << "EOF"
[main]
dns=none
EOF

as_root groupadd -fg 86 netdev &&
as_root /usr/sbin/usermod -a -G netdev lynose &&

as_root cat > /usr/share/polkit-1/rules.d/org.freedesktop.NetworkManager.rules << "EOF"
polkit.addRule(function(action, subject) {
    if (action.id.indexOf("org.freedesktop.NetworkManager.") == 0 && subject.isInGroup("netdev")) {
        return polkit.Result.YES;
    }
});
EOF



as_root systemctl enable NetworkManager &&

as_root systemctl disable NetworkManager-wait-online &&

${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
