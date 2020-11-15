#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/nasm-2.15.03
 then
  rm -rf /sources/nasm-2.15.03
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download http://www.nasm.us/pub/nasm/releasebuilds/2.15.03/nasm-2.15.03.tar.xz \
    /sources &&
check_and_download http://www.nasm.us/pub/nasm/releasebuilds/2.15.03/nasm-2.15.03-xdoc.tar.xz \
    /sources &&

md5sum -c ${SCRIPTPATH}/md5-nasm &&

tar xf /sources/nasm-2.15.03.tar.xz -C /sources/ &&

cd /sources/nasm-2.15.03 &&

tar -xf ../nasm-2.15.03-xdoc.tar.xz --strip-components=1 &&

./configure --prefix=/usr &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
${log} `basename "$0"` " built" blfs_all &&

as_root make install &&


as_root install -m755 -d         /usr/share/doc/nasm-2.15.03/html  &&
as_root cp -v doc/html/*.html    /usr/share/doc/nasm-2.15.03/html  &&
as_root cp -v doc/*.{txt,ps,pdf} /usr/share/doc/nasm-2.15.03 &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
