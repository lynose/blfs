#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/parted-3.3
 then
  rm -rf /sources/parted-3.3
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

wget https://ftp.gnu.org/gnu/parted/parted-3.3.tar.xz \
    --continue --directory-prefix=/sources &&

md5sum -c ${SCRIPTPATH}/md5-parted &&

tar xf /sources/parted-3.3.tar.xz -C /sources/ &&

cd /sources/parted-3.3 &&

./configure --prefix=/usr --disable-static &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
make -C doc html                                       &&
makeinfo --html      -o doc/html       doc/parted.texi &&
makeinfo --plaintext -o doc/parted.txt doc/parted.texi &&
${log} `basename "$0"` " built" blfs_all &&

sed -i '/t0251-gpt-unicode.sh/d' tests/Makefile &&
sed -i '/t6002-dm-busy.sh/d' tests/Makefile &&
sed -i '1s/python/&3/' tests/{gpt-header-move,msdos-overlap} &&
make check &&
${log} `basename "$0"` " check succeed" blfs_all &&

make install &&
install -v -m755 -d /usr/share/doc/parted-3.3/html &&
install -v -m644    doc/html/* \
                    /usr/share/doc/parted-3.3/html &&
install -v -m644    doc/{FAT,API,parted.{txt,html}} \
                    /usr/share/doc/parted-3.3 &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
