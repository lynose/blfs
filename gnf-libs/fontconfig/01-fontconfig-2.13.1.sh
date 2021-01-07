#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/fontconfig-2.13.1
 then
  rm -rf /sources/fontconfig-2.13.1
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download https://www.freedesktop.org/software/fontconfig/release/fontconfig-2.13.1.tar.bz2 \
    /sources &&

md5sum -c ${SCRIPTPATH}/md5-fontconfig &&

as_root tar xf /sources/fontconfig-2.13.1.tar.bz2 -C /sources/ &&

cd /sources/fontconfig-2.13.1 &&

rm -f src/fcobjshash.h &&

./configure --prefix=/usr        \
            --sysconfdir=/etc    \
            --localstatedir=/var \
            --disable-docs       \
            --docdir=/usr/share/doc/fontconfig-2.13.1  &&
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
as_root install -v -dm755 \
        /usr/share/{man/man{1,3,5},doc/fontconfig-2.13.1/fontconfig-devel} &&
as_root install -v -m644 fc-*/*.1         /usr/share/man/man1 &&
as_root install -v -m644 doc/*.3          /usr/share/man/man3 &&
as_root install -v -m644 doc/fonts-conf.5 /usr/share/man/man5 &&
as_root install -v -m644 doc/fontconfig-devel/* \
                                  /usr/share/doc/fontconfig-2.13.1/fontconfig-devel &&
as_root install -v -m644 doc/*.{pdf,sgml,txt,html} \
                                  /usr/share/doc/fontconfig-2.13.1 &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
