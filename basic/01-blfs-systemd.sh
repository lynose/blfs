#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /usr/src/blfs-systemd-units-20210122
 then
  as_root rm -rf /usr/src/blfs-systemd-units-20210122
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`
tar xf /sources/blfs-systemd-units-20210122.tar.xz -C /usr/src &&
ln -s /usr/src/blfs-systemd-units-20210122 /usr/src/blfs-systemd-units &&

${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
