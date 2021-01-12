#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/qemu-5.2.0
 then
  rm -rf /sources/qemu-5.2.0
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download http://download.qemu-project.org/qemu-5.2.0.tar.xz \
        /sources


md5sum -c ${SCRIPTPATH}/md5-qemu &&

tar xf /sources/qemu-5.2.0.tar.xz -C /sources/ &&

cd /sources/qemu-5.2.0 &&

if   [ $EUID = 0 ];        
  then
    as_root usermod -a -G kvm $USER
fi

if [ $(uname -m) = i686 ]; then
   QEMU_ARCH=i386-softmmu
else
   QEMU_ARCH=x86_64-softmmu
fi


mkdir -vp build &&
cd        build &&

../configure --prefix=/usr               \
             --sysconfdir=/etc           \
             --target-list=$QEMU_ARCH    \
             --audio-drv-list=alsa,pa       \
             --docdir=/usr/share/doc/qemu-5.2.0 &&

unset QEMU_ARCH &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
${log} `basename "$0"` " built" blfs_all &&

if [ ${ENABLE_TEST} == true ]
 then
  ninja test &&
  ${log} `basename "$0"` " check succeed" blfs_all ||
  ${log} `basename "$0"` " expected check fail?" blfs_all
fi

as_root make install &&

cat > ./65-kvm.rules << "EOF" &&
KERNEL=="kvm", GROUP="kvm", MODE="0660"
EOF
as_root mv -v 65-kvm.rules /lib/udev/rules.d/65-kvm.rules &&
as_root chgrp kvm  /usr/libexec/qemu-bridge-helper &&
as_root chmod 4750 /usr/libexec/qemu-bridge-helper &&
as_root ln -sfv qemu-system-`uname -m` /usr/bin/qemu &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
