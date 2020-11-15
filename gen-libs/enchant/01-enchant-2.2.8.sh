#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/enchant-2.2.8
 then
  rm -rf /sources/enchant-2.2.8
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download https://github.com/AbiWord/enchant/releases/download/v2.2.8/enchant-2.2.8.tar.gz \
    /sources &&

md5sum -c ${SCRIPTPATH}/md5-enchant &&

tar xf /sources/enchant-2.2.8.tar.gz -C /sources/ &&

cd /sources/enchant-2.2.8 &&

./configure --prefix=/usr --disable-static &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
${log} `basename "$0"` " built" blfs_all &&

as_root make install                                   &&
rm -rf /usr/include/enchant                    &&
ln -sfv enchant-2       /usr/include/enchant   &&
ln -sfv enchant-2       /usr/bin/enchant       &&
ln -sfv libenchant-2.so /usr/lib/libenchant.so &&
ln -sfv enchant-2.pc    /usr/lib/pkgconfig/enchant.pc &&

${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
