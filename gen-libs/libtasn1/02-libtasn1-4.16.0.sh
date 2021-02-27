#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/libtasn1-4.16.0
 then
  as_root rm -rf /sources/libtasn1-4.16.0
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download https://ftp.gnu.org/gnu/libtasn1/libtasn1-4.16.0.tar.gz \
        /sources &&


md5sum -c ${SCRIPTPATH}/md5-libtasn1 &&

tar xf /sources/libtasn1-4.16.0.tar.gz -C /sources/ &&

cd /sources/libtasn1-4.16.0 &&

./configure --prefix=/usr --disable-static --enable-gtk-doc &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
${log} `basename "$0"` " built" blfs_all &&

if [ ${ENABLE_TEST} == true ]
 then
  make check &&
  ${log} `basename "$0"` " check succeed" blfs_all ||
  ${log} `basename "$0"` " expected check fail?" blfs_all
fi

as_root make install &&
as_root make -C doc/reference install-data-local &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
