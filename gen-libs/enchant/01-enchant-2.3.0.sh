#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/enchant-2.3.0
 then
  rm -rf /sources/enchant-2.3.0
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download https://github.com/AbiWord/enchant/releases/download/v2.3.0/enchant-2.3.0.tar.gz \
    /sources &&

md5sum -c ${SCRIPTPATH}/md5-enchant &&

tar xf /sources/enchant-2.3.0.tar.gz -C /sources/ &&

cd /sources/enchant-2.3.0 &&

./configure --prefix=/usr --disable-static &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
${log} `basename "$0"` " built" blfs_all &&

as_root make install                                   &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
