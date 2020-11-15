#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/libburn-1.5.2
 then
  rm -rf /sources/libburn-1.5.2
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download http://files.libburnia-project.org/releases/libburn-1.5.2.tar.gz \
    /sources &&

md5sum -c ${SCRIPTPATH}/md5-libburn &&

tar xf /sources/libburn-1.5.2.tar.gz -C /sources/ &&

cd /sources/libburn-1.5.2 &&

./configure --prefix=/usr --disable-static &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
${log} `basename "$0"` " built" blfs_all &&

as_root make install &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
