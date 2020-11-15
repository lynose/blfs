#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/libdaemon-0.14
 then
  rm -rf /sources/libdaemon-0.14
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download http://0pointer.de/lennart/projects/libdaemon/libdaemon-0.14.tar.gz \
    /sources &&

md5sum -c ${SCRIPTPATH}/md5-libdaemon &&

tar xf /sources/libdaemon-0.14.tar.gz -C /sources/ &&

cd /sources/libdaemon-0.14 &&

./configure --prefix=/usr --disable-static &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
make -C doc doxygen &&
${log} `basename "$0"` " built" blfs_all &&


as_root make docdir=/usr/share/doc/libdaemon-0.14 install &&
as_root install -v -m755 -d /usr/share/doc/libdaemon-0.14/reference/html &&
as_root install -v -m644 doc/reference/html/* /usr/share/doc/libdaemon-0.14/reference/html &&
as_root install -v -m644 doc/reference/man/man3/* /usr/share/man/man3 &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
