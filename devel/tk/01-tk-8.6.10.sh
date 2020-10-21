#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/tk8.6.10
 then
  rm -rf /sources/tk8.6.10
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

wget https://downloads.sourceforge.net/tcl/tk8.6.10-src.tar.gz \
    --continue --directory-prefix=/sources &&

md5sum -c ${SCRIPTPATH}/md5-tk &&

tar xf /sources/tk8.6.10-src.tar.gz -C /sources/ &&

cd /sources/tk8.6.10 &&

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

make install &&
make install-private-headers &&
ln -v -sf wish8.6 /usr/bin/wish &&
chmod -v 755 /usr/lib/libtk8.6.so &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
