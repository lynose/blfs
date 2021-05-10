#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/hdparm-9.61
 then
  rm -rf /sources/hdparm-9.61
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download https://downloads.sourceforge.net/hdparm/hdparm-9.61.tar.gz \
        /sources &&


md5sum -c ${SCRIPTPATH}/md5-hdparm &&

tar xf /sources/hdparm-9.61.tar.gz -C /sources/ &&

cd /sources/hdparm-9.61 &&

make &&
${log} `basename "$0"` " built" blfs_all &&

as_root make install &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
