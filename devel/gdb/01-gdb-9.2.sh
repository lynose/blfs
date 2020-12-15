#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/gdb-9.2
 then
  rm -rf /sources/gdb-9.2
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download https://ftp.gnu.org/gnu/gdb/gdb-9.2.tar.xz \
        /sources


md5sum -c ${SCRIPTPATH}/md5-gdb &&

tar xf /sources/gdb-9.2.tar.xz -C /sources/ &&

cd /sources/gdb-9.2 &&

mkdir build &&
cd    build &&

../configure --prefix=/usr          \
             --with-system-readline \
             --with-python=/usr/bin/python3 &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
make -C gdb/doc doxy &&
${log} `basename "$0"` " built" blfs_all &&

# if [ ${ENABLE_TEST} == true ]
#  then
#   pushd gdb/testsuite &&
#   make  site.exp      &&
#   echo  "set gdb_test_timeout 120" >> site.exp &&
#   runtest
#   popd
#   ${log} `basename "$0"` " unexpected check succeed" blfs_all
#   ${log} `basename "$0"` " expected check fail?" blfs_all
# fi

as_root make -C gdb install &&
as_root install -d /usr/share/doc/gdb-9.2 &&
as_root rm -rf gdb/doc/doxy/xml &&
as_root cp -Rv gdb/doc/doxy /usr/share/doc/gdb-9.2 &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
