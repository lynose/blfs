#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/popt-1.18
 then
  rm -rf /sources/popt-1.18
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download http://ftp.rpm.org/popt/releases/popt-1.x/popt-1.18.tar.gz \
    /sources &&

md5sum -c ${SCRIPTPATH}/md5-popt &&

tar xf /sources/popt-1.18.tar.gz -C /sources/ &&

cd /sources/popt-1.18 &&

./configure --prefix=/usr --disable-static &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
sed -i 's@\./@src/@' Doxyfile &&
doxygen &&
${log} `basename "$0"` " built" blfs_all &&

make check &&
${log} `basename "$0"` " check succeed" blfs_all &&

as_root make install &&
as_root install -v -m755 -d /usr/share/doc/popt-1.18 &&
as_root install -v -m644 doxygen/html/* /usr/share/doc/popt-1.18 &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
