#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/LVM2.2.03.11
 then
  rm -rf /sources/LVM2.2.03.11
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download https://sourceware.org/ftp/lvm2/LVM2.2.03.11.tgz \
    /sources &&

md5sum -c ${SCRIPTPATH}/md5-LVM2 &&

tar xf /sources/LVM2.2.03.11.tgz -C /sources/ &&

cd /sources/LVM2.2.03.11 &&

SAVEPATH=$PATH                  &&
PATH=$PATH:/sbin:/usr/sbin      &&
./configure --prefix=/usr       \
            --exec-prefix=      \
            --enable-cmdlib     \
            --enable-pkgconfig  \
            --enable-dmeventd   \
            --enable-udev_sync  &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
PATH=$SAVEPATH                  &&
unset SAVEPATH  &&
${log} `basename "$0"` " built" blfs_all &&

if [ ${ENABLE_TEST} == true ]
 then
  as_root make -C tools install_tools_dynamic &&
  as_root make -C udev  install                 &&
  as_root make -C libdm install
  rm test/shell/lvconvert-raid-reshape.sh &&
  make S=shell/thin-flags.sh check_local &&
  ${log} `basename "$0"` " check succeed" blfs_all ||
  ${log} `basename "$0"` " expected check fail?" blfs_all
fi

as_root make install &&
as_root make install_systemd_units &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
