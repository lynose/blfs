#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/btrfs-progs-v5.7
 then
  rm -rf /sources/btrfs-progs-v5.7
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download https://www.kernel.org/pub/linux/kernel/people/kdave/btrfs-progs/btrfs-progs-v5.7.tar.xz \
    /sources &&

md5sum -c ${SCRIPTPATH}/md5-btrfs-progs &&

tar xf /sources/btrfs-progs-v5.7.tar.xz -C /sources/ &&

cd /sources/btrfs-progs-v5.7 &&

./configure --prefix=/usr \
            --bindir=/bin \
            --libdir=/lib  &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
make fssum &&

sed -i '/found/s/^/: #/' tests/convert-tests.sh &&

mv tests/convert-tests/010-reiserfs-basic/test.sh{,.broken}                 &&
mv tests/convert-tests/011-reiserfs-delete-all-rollback/test.sh{,.broken}   &&
mv tests/convert-tests/012-reiserfs-large-hole-extent/test.sh{,.broken}     &&
mv tests/convert-tests/013-reiserfs-common-inode-flags/test.sh{,.broken}    &&
mv tests/convert-tests/014-reiserfs-tail-handling/test.sh{,.broken} &&
${log} `basename "$0"` " built" blfs_all &&


if [ ${ENABLE_TEST} == true ]
 then
  pushd tests &&
    ./fsck-tests.sh
    ./mkfs-tests.sh  
    ./cli-tests.sh  
    ./convert-tests.sh 
    ./misc-tests.sh    
    ./fuzz-tests.sh    
  popd
  ${log} `basename "$0"` " check succeed" blfs_all ||
  ${log} `basename "$0"` " expected check fail?" blfs_all
fi


as_root make install &&

as_root ln -sfv ../../lib/$(readlink /lib/libbtrfs.so) /usr/lib/libbtrfs.so &&
as_root ln -sfv ../../lib/$(readlink /lib/libbtrfsutil.so) /usr/lib/libbtrfsutil.so &&
as_root rm -fv /lib/libbtrfs.{a,so} /lib/libbtrfsutil.{a,so} &&
as_root mv -v /bin/{mkfs,fsck}.btrfs /sbin &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
