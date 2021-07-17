#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/hdparm-9.62
 then
  rm -rf /sources/hdparm-9.62
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download https://downloads.sourceforge.net/hdparm/hdparm-9.62.tar.gz \
        /sources &&


md5sum -c ${SCRIPTPATH}/md5-hdparm &&

tar xf /sources/hdparm-9.62.tar.gz -C /sources/ &&

cd /sources/hdparm-9.62 &&

make &&
${log} `basename "$0"` " built" blfs_all &&

as_root make binprefix=/usr install &&

${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
