#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/usbutils-012
 then
  rm -rf /sources/usbutils-012
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download https://www.kernel.org/pub/linux/utils/usb/usbutils/usbutils-012.tar.xz \
    /sources &&

md5sum -c ${SCRIPTPATH}/md5-usbutils &&

tar xf /sources/usbutils-012.tar.xz -C /sources/ &&

cd /sources/usbutils-012 &&

./autogen.sh --prefix=/usr --datadir=/usr/share/hwdata &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
${log} `basename "$0"` " built" blfs_all &&

as_root make install &&
install -dm755 /usr/share/hwdata/ &&
check_and_download http://www.linux-usb.org/usb.ids -O /usr/share/hwdata/usb.ids
${log} `basename "$0"` " installed" blfs_all &&

as_root cat > /lib/systemd/system/update-usbids.service << "EOF" &&
[Unit]
Description=Update usb.ids file
Documentation=man:lsusb(8)
DefaultDependencies=no
After=local-fs.target network-online.target
Before=shutdown.target

[Service]
Type=oneshot
RemainAfterExit=yes
ExecStart=/usr/bin/check_and_download http://www.linux-usb.org/usb.ids -O /usr/share/hwdata/usb.ids
EOF
as_root cat > /lib/systemd/system/update-usbids.timer << "EOF" &&
[Unit]
Description=Update usb.ids file weekly

[Timer]
OnCalendar=Sun 03:00:00
Persistent=true

[Install]
WantedBy=timers.target
EOF
systemctl enable update-usbids.timer
${log} `basename "$0"` " systemd update configured" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
