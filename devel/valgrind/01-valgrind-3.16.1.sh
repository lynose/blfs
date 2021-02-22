#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/valgrind-3.16.1
 then
  rm -rf /sources/valgrind-3.16.1
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download https://sourceware.org/ftp/valgrind/valgrind-3.16.1.tar.bz2 \
        /sources


md5sum -c ${SCRIPTPATH}/md5-valgrind &&

tar xf /sources/valgrind-3.16.1.tar.bz2 -C /sources/ &&

cd /sources/valgrind-3.16.1 &&

sed -i 's/arm64/amd64/' gdbserver_tests/nlcontrolc.vgtest &&

sed -i 's|/doc/valgrind||' docs/Makefile.in &&

./configure --prefix=/usr \
            --datadir=/usr/share/doc/valgrind-3.16.1 &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
${log} `basename "$0"` " built" blfs_all &&

# if [ ${ENABLE_TEST} == true ]
#  then
#   sed -e 's@prereq:.*@prereq: false@' \
#     -i {helgrind,drd}/tests/pth_cond_destroy_busy.vgtest
#   make  make regtest &&
#   ${log} `basename "$0"` " check succeed" blfs_all ||
#   ${log} `basename "$0"` " expected check fail?" blfs_all
# fi

as_root make install &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
