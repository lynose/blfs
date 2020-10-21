#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/Python-3.8.5
 then
  rm -rf /sources/Python-3.8.5
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

wget https://www.python.org/ftp/python/3.8.5/Python-3.8.5.tar.xz \
    --continue --directory-prefix=/sources &&

md5sum -c ${SCRIPTPATH}/md5-python3 &&

tar xf /sources/Python-3.8.5.tar.xz -C /sources/ &&

cd /sources/Python-3.8.5 &&

CXX="/usr/bin/g++"              \
./configure --prefix=/usr       \
            --enable-shared     \
            --with-system-expat \
            --with-system-ffi   \
            --enable-optimization \
            --with-lto          \
            --with-ensurepip=yes &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
${log} `basename "$0"` " built" blfs_all &&


make install &&

chmod -v 755 /usr/lib/libpython3.8.so &&
chmod -v 755 /usr/lib/libpython3.so &&
ln -svfn python-3.8.5 /usr/share/doc/python-3 &&

${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
