#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/unixODBC-2.3.7
 then
  rm -rf /sources/unixODBC-2.3.7
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download ftp://ftp.unixodbc.org/pub/unixODBC/unixODBC-2.3.7.tar.gz \
        /sources


md5sum -c ${SCRIPTPATH}/md5-unixODBC &&

tar xf /sources/unixODBC-2.3.7.tar.gz -C /sources/ &&

cd /sources/unixODBC-2.3.7 &&

./configure --prefix=/usr \
            --sysconfdir=/etc/unixODBC &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
${log} `basename "$0"` " built" blfs_all &&

as_root make install &&


find doc -name "Makefile*" -delete                &&
chmod 644 doc/{lst,ProgrammerManual/Tutorial}/*   &&

as_root install -v -m755 -d /usr/share/doc/unixODBC-2.3.7 &&
as_root cp      -v -R doc/* /usr/share/doc/unixODBC-2.3.7 &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
