#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/fltk-1.3.6
 then
  as_root rm -rf /sources/fltk-1.3.6
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download http://fltk.org/pub/fltk/1.3.6/fltk-1.3.6-source.tar.gz \
        /sources &&


md5sum -c ${SCRIPTPATH}/md5-fltk &&

tar xf /sources/fltk-1.3.6-source.tar.gz -C /sources/ &&

cd /sources/fltk-1.3.6 &&

sed -i -e '/cat./d' documentation/Makefile       &&

./configure --prefix=/usr    \
            --enable-shared  &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
make -C documentation html &&
${log} `basename "$0"` " built" blfs_all &&

if [ ${ENABLE_TEST} == true ]
 then
  test/unittests &&
  ${log} `basename "$0"` " check succeed" blfs_all ||
  ${log} `basename "$0"` " expected check fail?" blfs_all
fi

as_root make docdir=/usr/share/doc/fltk-1.3.6 install &&
as_root make -C test          docdir=/usr/share/doc/fltk-1.3.6 install-linux &&
as_root make -C documentation docdir=/usr/share/doc/fltk-1.3.6 install-linux &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
