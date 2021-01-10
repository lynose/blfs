#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/bluez-5.55
 then
  rm -rf /sources/bluez-5.55
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download https://www.kernel.org/pub/linux/bluetooth/bluez-5.55.tar.xz \
    /sources &&

md5sum -c ${SCRIPTPATH}/md5-bluez &&

tar xf /sources/bluez-5.55.tar.xz -C /sources/ &&

cd /sources/bluez-5.55 &&

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
as_root install -v -dm755 /usr/share/doc/bluez-5.55 &&
as_root install -v -m644 doc/*.txt /usr/share/doc/bluez-5.55 &&
as_root systemctl enable bluetooth &&
as_root systemctl enable --global obex &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
