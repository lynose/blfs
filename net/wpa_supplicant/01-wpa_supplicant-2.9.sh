#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/wpa_supplicant-2.9
 then
  rm -rf /sources/wpa_supplicant-2.9
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download https://w1.fi/releases/wpa_supplicant-2.9.tar.gz \
    /sources &&

md5sum -c ${SCRIPTPATH}/md5-wpa_supplicant &&

tar xf /sources/wpa_supplicant-2.9.tar.gz -C /sources/ &&

cd /sources/wpa_supplicant-2.9 &&

cat > wpa_supplicant/.config << "EOF"
CONFIG_BACKEND=file
CONFIG_CTRL_IFACE=y
CONFIG_DEBUG_FILE=y
CONFIG_DEBUG_SYSLOG=y
CONFIG_DEBUG_SYSLOG_FACILITY=LOG_DAEMON
CONFIG_DRIVER_NL80211=y
CONFIG_DRIVER_WEXT=y
CONFIG_DRIVER_WIRED=y
CONFIG_EAP_GTC=y
CONFIG_EAP_LEAP=y
CONFIG_EAP_MD5=y
CONFIG_EAP_MSCHAPV2=y
CONFIG_EAP_OTP=y
CONFIG_EAP_PEAP=y
CONFIG_EAP_TLS=y
CONFIG_EAP_TTLS=y
CONFIG_IEEE8021X_EAPOL=y
CONFIG_IPV6=y
CONFIG_LIBNL32=y
CONFIG_PEERKEY=y
CONFIG_PKCS12=y
CONFIG_READLINE=y
CONFIG_SMARTCARD=y
CONFIG_WPS=y
CFLAGS += -I/usr/include/libnl3
EOF

cat >> wpa_supplicant/.config << "EOF"
CONFIG_CTRL_IFACE_DBUS=y
CONFIG_CTRL_IFACE_DBUS_NEW=y
CONFIG_CTRL_IFACE_DBUS_INTRO=y
EOF

${log} `basename "$0"` " configured" blfs_all &&

cd wpa_supplicant &&
make BINDIR=/sbin LIBDIR=/lib &&
pushd wpa_gui-qt4 &&
qmake wpa_gui.pro &&
make &&
popd
${log} `basename "$0"` " built" blfs_all &&

as_root install -v -m755 wpa_{cli,passphrase,supplicant} /sbin/ &&
as_root install -v -m644 doc/docbook/wpa_supplicant.conf.5 /usr/share/man/man5/ &&
as_root install -v -m644 doc/docbook/wpa_{cli,passphrase,supplicant}.8 /usr/share/man/man8/ &&
as_root install -v -m644 systemd/*.service /lib/systemd/system/ &&
as_root install -v -m644 dbus/fi.w1.wpa_supplicant1.service \
                 /usr/share/dbus-1/system-services/ &&
as_root install -v -d -m755 /etc/dbus-1/system.d &&
as_root install -v -m644 dbus/dbus-wpa_supplicant.conf \
                 /etc/dbus-1/system.d/wpa_supplicant.conf &&
systemctl enable wpa_supplicant &&
as_root install -v -m755 wpa_gui-qt4/wpa_gui /usr/bin/ &&
as_root install -v -m644 doc/docbook/wpa_gui.8 /usr/share/man/man8/ &&
as_root install -v -m644 wpa_gui-qt4/wpa_gui.desktop /usr/share/applications/ &&
as_root install -v -m644 wpa_gui-qt4/icons/wpa_gui.svg /usr/share/pixmaps/ &&
update-desktop-database -q &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
