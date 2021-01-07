#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/gptfdisk-1.0.5
 then
  rm -rf /sources/gptfdisk-1.0.5
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

if [ ! -f /sources/gptfdisk-1.0.5.tar.gz ];  
 then
  check_and_download https://downloads.sourceforge.net/gptfdisk/gptfdisk-1.0.5.tar.gz \
    /sources
fi

if [ ! -f /sources/gptfdisk-1.0.5-convenience-1.patch ];  
 then
  check_and_download http://www.linuxfromscratch.org/patches/blfs/10.0/gptfdisk-1.0.5-convenience-1.patch \
    /sources
fi
md5sum -c ${SCRIPTPATH}/md5-gptfdisk &&

tar xf /sources/gptfdisk-1.0.5.tar.gz -C /sources/ &&
 
cd /sources/gptfdisk-1.0.5 &&

patch -Np1 -i ../gptfdisk-1.0.5-convenience-1.patch &&
sed -i 's|ncursesw/||' gptcurses.cc &&
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
