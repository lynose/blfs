#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/gptfdisk-1.0.5
 then
  rm -rf /sources/gptfdisk-1.0.5
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

wget https://downloads.sourceforge.net/gptfdisk/gptfdisk-1.0.5.tar.gz \
    --continue --directory-prefix=/sources &&
wget http://www.linuxfromscratch.org/patches/blfs/10.0/gptfdisk-1.0.5-convenience-1.patch \
    --continue --directory-prefix=/sources &&
md5sum -c ${SCRIPTPATH}/md5-gptfdisk &&

tar xf /sources/gptfdisk-1.0.5.tar.gz -C /sources/ &&

cd /sources/gptfdisk-1.0.5 &&

patch -Np1 -i ../gptfdisk-1.0.5-convenience-1.patch &&
sed -i 's|ncursesw/||' gptcurses.cc &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
${log} `basename "$0"` " built" blfs_all &&

make test &&
${log} `basename "$0"` " check succeed" blfs_all &&

make install &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
