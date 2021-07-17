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
make BINDIR=/usr/sbin LIBDIR=/usr/lib &&
${log} `basename "$0"` " built" blfs_all &&

as_root install -v -m755 wpa_{cli,passphrase,supplicant} /usr/sbin/ &&
as_root install -v -m644 doc/docbook/wpa_supplicant.conf.5 /usr/share/man/man5/ &&
as_root install -v -m644 doc/docbook/wpa_{cli,passphrase,supplicant}.8 /usr/share/man/man8/ &&
install -v -m644 systemd/*.service /lib/systemd/system/ &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
