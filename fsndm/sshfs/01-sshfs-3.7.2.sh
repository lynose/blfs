#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/sshfs-3.7.2
 then
  as_root rm -rf /sources/sshfs-3.7.2
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download https://github.com/libfuse/sshfs/releases/download/sshfs-3.7.2/sshfs-3.7.2.tar.xz \
        /sources &&


md5sum -c ${SCRIPTPATH}/md5-sshfs &&

tar xf /sources/sshfs-3.7.2.tar.xz -C /sources/ &&

cd /sources/sshfs-3.7.2 &&

mkdir build &&
cd    build &&
          
meson --prefix=/usr .. &&
${log} `basename "$0"` " configured" blfs_all &&

ninja &&
${log} `basename "$0"` " built" blfs_all &&

as_root ninja install &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
