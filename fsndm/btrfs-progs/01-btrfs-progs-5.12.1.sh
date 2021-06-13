#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/btrfs-progs-v5.12.1
 then
  as_root rm -rf /sources/btrfs-progs-v5.12.1
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download https://www.kernel.org/pub/linux/kernel/people/kdave/btrfs-progs/btrfs-progs-v5.12.1.tar.xz \
    /sources &&

md5sum -c ${SCRIPTPATH}/md5-btrfs-progs &&

tar xf /sources/btrfs-progs-v5.12.1.tar.xz -C /sources/ &&

cd /sources/btrfs-progs-v5.12.1 &&

./configure --prefix=/usr \
            --bindir=/bin \
            --libdir=/lib \
            --with-pkgconfigdir=/usr/lib/pkgconfig &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
${log} `basename "$0"` " built" blfs_all &&


if [ ${ENABLE_TEST} == true ]
 then
  make fssum &&

  pushd tests &&
   ./fsck-tests.sh &&
   ./mkfs-tests.sh &&
   ./cli-tests.sh &&
   ./convert-tests.sh &&
   ./misc-tests.sh &&
   ./fuzz-tests.sh
  popd
  ${log} `basename "$0"` " check succeed" blfs_all ||
  ${log} `basename "$0"` " expected check fail?" blfs_all
fi


as_root make install &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
