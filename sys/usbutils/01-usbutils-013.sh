#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/usbutils-013
 then
  rm -rf /sources/usbutils-013
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download https://www.kernel.org/pub/linux/utils/usb/usbutils/usbutils-013.tar.xz \
    /sources &&

md5sum -c ${SCRIPTPATH}/md5-usbutils &&

tar xf /sources/usbutils-013.tar.xz -C /sources/ &&

cd /sources/usbutils-013 &&

./autogen.sh --prefix=/usr --datadir=/usr/share/hwdata &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
${log} `basename "$0"` " built" blfs_all &&

as_root make install &&
install -dm755 /usr/share/hwdata/ &&
wget http://www.linux-usb.org/usb.ids -O /usr/share/hwdata/usb.ids &&
${log} `basename "$0"` " installed" blfs_all &&

cat > ./update-usbids.service << "EOF" &&
[Unit]
Description=Update usb.ids file
Documentation=man:lsusb(8)
DefaultDependencies=no
After=local-fs.target network-online.target
Before=shutdown.target

[Service]
Type=oneshot
RemainAfterExit=yes
ExecStart=/usr/bin/wget http://www.linux-usb.org/usb.ids -O /usr/share/hwdata/usb.ids
EOF

as_root mv -v ./update-usbids.service /lib/systemd/system/update-usbids.service &&

cat > ./update-usbids.timer << "EOF" &&
[Unit]
Description=Update usb.ids file weekly

[Timer]
OnCalendar=Sun 03:00:00
Persistent=true

[Install]
WantedBy=timers.target
EOF

as_root mv -v ./update-usbids.timer /lib/systemd/system/update-usbids.timer &&

systemctl enable update-usbids.timer
${log} `basename "$0"` " systemd update configured" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
