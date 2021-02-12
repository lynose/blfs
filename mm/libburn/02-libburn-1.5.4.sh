#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/libburn-1.5.4
 then
  as_root rm -rf /sources/libburn-1.5.4
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download http://files.libburnia-project.org/releases/libburn-1.5.4.tar.gz \
    /sources &&

md5sum -c ${SCRIPTPATH}/md5-libburn &&

tar xf /sources/libburn-1.5.4.tar.gz -C /sources/ &&

cd /sources/libburn-1.5.4 &&

./configure --prefix=/usr --disable-static &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
doxygen doc/doxygen.conf &&
${log} `basename "$0"` " built" blfs_all &&

as_root make install &&
as_root install -v -dm755 /usr/share/doc/libburn-1.5.4 &&
as_root install -v -m644 doc/html/* /usr/share/doc/libburn-1.5.4 &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
