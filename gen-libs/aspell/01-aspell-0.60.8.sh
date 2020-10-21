#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/aspell-0.60.8
 then
  rm -rf /sources/aspell-0.60.8
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

wget https://ftp.gnu.org/gnu/aspell/aspell-0.60.8.tar.gz \
    --continue --directory-prefix=/sources &&
    
wget https://ftp.gnu.org/gnu/aspell/dict/de/aspell6-de-20161207-7-0.tar.bz2 \
    --continue --directory-prefix=/sources &&
wget https://ftp.gnu.org/gnu/aspell/dict/en/aspell6-en-2019.10.06-0.tar.bz2 \
    --continue --directory-prefix=/sources &&

md5sum -c ${SCRIPTPATH}/md5-aspell &&

tar xf /sources/aspell-0.60.8.tar.gz -C /sources/ &&
tar xf /sources/aspell6-de-20161207-7-0.tar.bz2 -C /sources/ &&
tar xf /sources/aspell6-en-2019.10.06-0.tar.bz2 -C /sources/ &&

cd /sources/aspell-0.60.8 &&

./configure --prefix=/usr &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
${log} `basename "$0"` " built" blfs_all &&

make install &&
ln -svfn aspell-0.60 /usr/lib/aspell &&

install -v -m755 -d /usr/share/doc/aspell-0.60.8/aspell{,-dev}.html &&

install -v -m644 manual/aspell.html/* \
    /usr/share/doc/aspell-0.60.8/aspell.html &&

install -v -m644 manual/aspell-dev.html/* \
    /usr/share/doc/aspell-0.60.8/aspell-dev.html &&
install -v -m 755 scripts/ispell /usr/bin/ &&
install -v -m 755 scripts/spell /usr/bin/ &&

cd /sources/aspell6-de-20161207-7-0 &&
./configure &&
make &&
make install &&

cd /sources/aspell6-en-2019.10.06-0 &&
./configure &&
make &&
make install &&

${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
