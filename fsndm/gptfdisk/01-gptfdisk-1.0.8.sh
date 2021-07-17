#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/gptfdisk-1.0.8
 then
  rm -rf /sources/gptfdisk-1.0.8
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download https://downloads.sourceforge.net/gptfdisk/gptfdisk-1.0.8.tar.gz \
    /sources

check_and_download http://www.linuxfromscratch.org/patches/blfs/svn/gptfdisk-1.0.8-convenience-1.patch \
    /sources

md5sum -c ${SCRIPTPATH}/md5-gptfdisk &&

tar xf /sources/gptfdisk-1.0.8.tar.gz -C /sources/ &&
 
cd /sources/gptfdisk-1.0.8 &&

patch -Np1 -i ../gptfdisk-1.0.8-convenience-1.patch &&
sed -i 's|ncursesw/||' gptcurses.cc &&
sed -i 's|sbin|usr/sbin|' Makefile &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
${log} `basename "$0"` " built" blfs_all &&

if [ ${ENABLE_TEST} == true ]
 then
  make test &&
  ${log} `basename "$0"` " check succeed" blfs_all ||
  ${log} `basename "$0"` " expected check fail?" blfs_all
fi

as_root make install &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
