#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/parted-3.4
 then
  as_root rm -rf /sources/parted-3.4
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download https://ftp.gnu.org/gnu/parted/parted-3.4.tar.xz \
    /sources &&

md5sum -c ${SCRIPTPATH}/md5-parted &&

tar xf /sources/parted-3.4.tar.xz -C /sources/ &&

cd /sources/parted-3.4 &&

./configure --prefix=/usr --disable-static &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
make -C doc html                                       &&
makeinfo --html      -o doc/html       doc/parted.texi &&
makeinfo --plaintext -o doc/parted.txt doc/parted.texi &&
texi2pdf             -o doc/parted.pdf doc/parted.texi &&
texi2dvi             -o doc/parted.dvi doc/parted.texi &&
dvips                -o doc/parted.ps  doc/parted.dvi &&
${log} `basename "$0"` " built" blfs_all &&

if [ ${ENABLE_TEST} == true ]
 then
  make check &&
  ${log} `basename "$0"` " check succeed" blfs_all ||
  ${log} `basename "$0"` " expected check fail?" blfs_all
fi

as_root make install &&
as_root install -v -m755 -d /usr/share/doc/parted-3.4/html &&
as_root install -v -m644    doc/html/* \
                    /usr/share/doc/parted-3.4/html &&
as_root install -v -m644    doc/{FAT,API,parted.{txt,html}} \
                    /usr/share/doc/parted-3.4 &&
as_root install -v -m644 doc/FAT doc/API doc/parted.{pdf,ps,dvi} \
                    /usr/share/doc/parted-3.4 &&                    
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
