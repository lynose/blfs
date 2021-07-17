#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/bluez-5.60
 then
  as_root rm -rf /sources/bluez-5.60
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download https://www.kernel.org/pub/linux/bluetooth/bluez-5.60.tar.xz \
    /sources &&

  
md5sum -c ${SCRIPTPATH}/md5-bluez &&

tar xf /sources/bluez-5.60.tar.xz -C /sources/ &&

cd /sources/bluez-5.60 &&

./configure --prefix=/usr         \
            --sysconfdir=/etc     \
            --localstatedir=/var  \
            --enable-library &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
${log} `basename "$0"` " built" blfs_all &&

if [ ${ENABLE_TEST} == true ]
 then
  make check &&
  ${log} `basename "$0"` " check succeed" blfs_all ||
  ${log} `basename "$0"` " expected check fail?" blfs_all
fi

as_root make install &&
as_root ln -svf ../libexec/bluetooth/bluetoothd /usr/sbin &&
as_root install -v -dm755 /etc/bluetooth &&
as_root install -v -m644 src/main.conf /etc/bluetooth/main.conf &&
as_root install -v -dm755 /usr/share/doc/bluez-5.60 &&
as_root install -v -m644 doc/*.txt /usr/share/doc/bluez-5.60 &&

cat > /tmp/rfcomm.conf << "EOF"
# Start rfcomm.conf
# Set up the RFCOMM configuration of the Bluetooth subsystem in the Linux kernel.
# Use one line per command
# See the rfcomm man page for options


# End of rfcomm.conf
EOF

cat > /tmp/uart.conf << "EOF"
# Start uart.conf
# Attach serial devices via UART HCI to BlueZ stack
# Use one line per device
# See the hciattach man page for options

# End of uart.conf
EOF
as_root install -m644 --owner=root /tmp/uart.conf /etc/bluetooth/uart.conf &&
as_root install -m644 --owner=root /tmp/rfcomm.conf /etc/bluetooth/rfcomm.conf &&
as_root systemctl enable bluetooth &&
as_root systemctl enable --global obex &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
