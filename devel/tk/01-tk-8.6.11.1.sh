#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/tk8.6.11
 then
  rm -rf /sources/tk8.6.11
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download https://downloads.sourceforge.net/tcl/tk8.6.11.1-src.tar.gz \
    /sources


md5sum -c ${SCRIPTPATH}/md5-tk &&

tar xf /sources/tk8.6.11.1-src.tar.gz -C /sources/ &&

cd /sources/tk8.6.11 &&

cd unix &&
./configure --prefix=/usr \
            --mandir=/usr/share/man \
            $([ $(uname -m) = x86_64 ] && echo --enable-64bit) &&
${log} `basename "$0"` " configured" blfs_all &&

make &&

sed -e "s@^\(TK_SRC_DIR='\).*@\1/usr/include'@" \
    -e "/TK_B/s@='\(-L\)\?.*unix@='\1/usr/lib@" \
    -i tkConfig.sh &&
${log} `basename "$0"` " built" blfs_all &&

as_root make install &&
as_root make install-private-headers &&
as_root ln -v -sf wish8.6 /usr/bin/wish &&
as_root chmod -v 755 /usr/lib/libtk8.6.so &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
