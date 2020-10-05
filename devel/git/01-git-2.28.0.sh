#!/bin/bash

${log} `basename "$0"` " started" blfs_all &&

if test -d /sources/git-2.28.0
 then
  rm -rf /sources/git-2.28.0
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

${log} `basename "$0"` " Downloading" blfs_all &&
wget https://www.kernel.org/pub/software/scm/git/git-2.28.0.tar.xz \
--continue --directory-prefix=/sources &&

wget https://www.kernel.org/pub/software/scm/git/git-manpages-2.28.0.tar.xz \
--continue --directory-prefix=/sources &&

wget https://www.kernel.org/pub/software/scm/git/git-htmldocs-2.28.0.tar.xz \
--continue --directory-prefix=/sources &&

md5sum -c ${SCRIPTPATH}/md5-git &&

tar xf /sources/git-2.28.0.tar.xz -C /sources/ &&

cd /sources/git-2.28.0 &&

./configure --prefix=/usr \
            --with-gitconfig=/etc/gitconfig \
            --with-python=python3 &&
${log} `basename "$0"` " configured" blfs_all &&

make && 
${log} `basename "$0"` " build" blfs_all &&

make test &&
${log} `basename "$0"` " check succeed" blfs_all &&

make perllibdir=/usr/lib/perl5/5.32/site_perl install &&

${log} `basename "$0"` " installed" blfs_all &&

tar -xf ../git-manpages-2.28.0.tar.xz \
    -C /usr/share/man --no-same-owner --no-overwrite-dir &&


mkdir -vp   /usr/share/doc/git-2.28.0 &&
tar   -xf   ../git-htmldocs-2.28.0.tar.xz \
      -C    /usr/share/doc/git-2.28.0 --no-same-owner --no-overwrite-dir &&

find        /usr/share/doc/git-2.28.0 -type d -exec chmod 755 {} \; &&
find        /usr/share/doc/git-2.28.0 -type f -exec chmod 644 {} \; &&
mkdir -vp /usr/share/doc/git-2.28.0/man-pages/{html,text}         &&
mv        /usr/share/doc/git-2.28.0/{git*.txt,man-pages/text}     &&
mv        /usr/share/doc/git-2.28.0/{git*.,index.,man-pages/}html &&

mkdir -vp /usr/share/doc/git-2.28.0/technical/{html,text}         &&
mv        /usr/share/doc/git-2.28.0/technical/{*.txt,text}        &&
mv        /usr/share/doc/git-2.28.0/technical/{*.,}html           &&

mkdir -vp /usr/share/doc/git-2.28.0/howto/{html,text}             &&
mv        /usr/share/doc/git-2.28.0/howto/{*.txt,text}            &&
mv        /usr/share/doc/git-2.28.0/howto/{*.,}html               &&

sed -i '/^<a href=/s|howto/|&html/|' /usr/share/doc/git-2.28.0/howto-index.html &&
sed -i '/^\* link:/s|howto/|&html/|' /usr/share/doc/git-2.28.0/howto-index.txt &&
${log} `basename "$0"` " installed docs and manpages" blfs_all &&

${log} `basename "$0"` " finished" blfs_all
