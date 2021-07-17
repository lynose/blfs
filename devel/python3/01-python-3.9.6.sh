#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/Python-3.9.6
 then
  as_root rm -rf /sources/Python-3.9.6
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download https://www.python.org/ftp/python/3.9.6/Python-3.9.6.tar.xz \
    /sources &&

md5sum -c ${SCRIPTPATH}/md5-python3 &&

tar xf /sources/Python-3.9.6.tar.xz -C /sources/ &&

cd /sources/Python-3.9.6 &&

sed 's|cpython/||' -i Include/cpython/pystate.h &&

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

as_root ln -svfn python-3.9.6 /usr/share/doc/python-3 &&

echo "export PYTHONDOCS=/usr/share/doc/python-3/html" >> /tmp/python.sh &&
as_root install -vm644 --owner=root /tmp/python.sh /etc/profile.d/ &&

${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
