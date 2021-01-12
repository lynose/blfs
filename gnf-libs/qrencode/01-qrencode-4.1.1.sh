#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/qrencode-4.1.1
 then
  rm -rf /sources/qrencode-4.1.1
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download https://fukuchi.org/works/qrencode/qrencode-4.1.1.tar.bz2 \
        /sources &&

sha512sum -c ${SCRIPTPATH}/qrencode-4.1.1.tar.bz2.sha &&

tar xf /sources/qrencode-4.1.1.tar.bz2 -C /sources/ &&

cd /sources/qrencode-4.1.1 &&

./configure --prefix=/usr --disable-static &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
doxygen &&
${log} `basename "$0"` " built" blfs_all &&

as_root make install &&
as_root install -vdm 755 /usr/share/doc/qrencode-4.1.1 &&
as_root mv html/* /usr/share/doc/qrencode-4.1.1 &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
