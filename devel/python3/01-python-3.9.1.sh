#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/Python-3.9.1
 then
  rm -rf /sources/Python-3.9.1
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download https://www.python.org/ftp/python/3.9.1/Python-3.9.1.tar.xz \
    /sources &&

md5sum -c ${SCRIPTPATH}/md5-python3 &&

tar xf /sources/Python-3.9.1.tar.xz -C /sources/ &&

cd /sources/Python-3.9.1 &&

CXX="/usr/bin/g++"              \
./configure --prefix=/usr       \
            --enable-shared     \
            --with-system-expat \
            --with-system-ffi   \
            --enable-optimization \
            --with-ensurepip=yes &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
${log} `basename "$0"` " built" blfs_all &&


as_root make install &&

as_root chmod -v 755 /usr/lib/libpython3.8.so &&
as_root chmod -v 755 /usr/lib/libpython3.so &&
as_root ln -svfn python-3.9.1 /usr/share/doc/python-3 &&

${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
