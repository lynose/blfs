#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/qpdf-10.0.1
 then
  rm -rf /sources/qpdf-10.0.1
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

wget https://github.com/qpdf/qpdf/releases/download/release-qpdf-10.0.1/qpdf-10.0.1.tar.gz \
    --continue --directory-prefix=/sources &&

md5sum -c ${SCRIPTPATH}/md5-qpdf &&

tar xf /sources/qpdf-10.0.1.tar.gz -C /sources/ &&

cd /sources/qpdf-10.0.1 &&

./configure --prefix=/usr    \
            --disable-static \
            --docdir=/usr/share/doc/qpdf-10.0.1 &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
${log} `basename "$0"` " built" blfs_all &&

make check &&
${log} `basename "$0"` " check succeed" blfs_all &&

make install &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
