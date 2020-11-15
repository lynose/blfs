#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/LVM2.2.03.10
 then
  rm -rf /sources/LVM2.2.03.10
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download https://sourceware.org/ftp/lvm2/LVM2.2.03.10.tgz \
    /sources &&

md5sum -c ${SCRIPTPATH}/md5-LVM2 &&

tar xf /sources/LVM2.2.03.10.tgz -C /sources/ &&

cd /sources/LVM2.2.03.10 &&

SAVEPATH=$PATH                  &&
PATH=$PATH:/sbin:/usr/sbin      &&
./configure --prefix=/usr       \
            --exec-prefix=      \
            --enable-cmdlib     \
            --enable-pkgconfig  \
            --enable-udev_sync  &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
PATH=$SAVEPATH                  &&
unset SAVEPATH  &&
${log} `basename "$0"` " built" blfs_all &&

make check &&
${log} `basename "$0"` " unexpected check succeed" blfs_all
${log} `basename "$0"` " expected check fail?" blfs_all &&

as_root make install &&
as_root make install_systemd_units &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
