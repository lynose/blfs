#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/asciidoc-9.1.0
 then
  rm -rf /sources/asciidoc-9.1.0
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download https://github.com/asciidoc/asciidoc-py3/releases/download/9.1.0/asciidoc-9.1.0.tar.gz \
    /sources &&

md5sum -c ${SCRIPTPATH}/md5-asciidoc &&

tar xf /sources/asciidoc-9.1.0.tar.gz -C /sources/ &&

cd /sources/asciidoc-9.1.0 &&

sed -i 's:doc/testasciidoc.1::' Makefile.in &&
rm doc/testasciidoc.1.txt &&

./configure --prefix=/usr     \
            --sysconfdir=/etc \
            --docdir=/usr/share/doc/asciidoc-9.1.0 &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
${log} `basename "$0"` " built" blfs_all &&

as_root make install &&
as_root make docs &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
