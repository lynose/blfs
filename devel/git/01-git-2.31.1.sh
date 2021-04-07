#!/bin/bash

${log} `basename "$0"` " started" blfs_all &&

if test -d /sources/git-2.31.1
 then
  as_root rm -rf /sources/git-2.31.1
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

${log} `basename "$0"` " Downloading" blfs_all &&
check_and_download https://www.kernel.org/pub/software/scm/git/git-2.31.1.tar.xz \
/sources &&

md5sum -c ${SCRIPTPATH}/md5-git &&

tar xf /sources/git-2.31.1.tar.xz -C /sources/ &&

cd /sources/git-2.31.1 &&

./configure --prefix=/usr \
            --with-gitconfig=/etc/gitconfig \
            --with-python=python3 &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
make html &&
make man &&
${log} `basename "$0"` " build" blfs_all &&

if [ ${ENABLE_TEST} == true ]
 then
  make test &&
  ${log} `basename "$0"` " check succeed" blfs_all ||
  ${log} `basename "$0"` " expected check fail?" blfs_all
fi

as_root make perllibdir=/usr/lib/perl5/5.32/site_perl install &&
as_root make install-man &&
as_root make htmldir=/usr/share/doc/git-2.31.1 install-html &&
${log} `basename "$0"` " installed" blfs_all &&

as_root mkdir -vp /usr/share/doc/git-2.31.1/man-pages/{html,text}         &&
as_root mv        /usr/share/doc/git-2.31.1/{git*.txt,man-pages/text}     &&
as_root mv        /usr/share/doc/git-2.31.1/{git*.,index.,man-pages/}html &&

as_root mkdir -vp /usr/share/doc/git-2.31.1/technical/{html,text}         &&
as_root mv        /usr/share/doc/git-2.31.1/technical/{*.txt,text}        &&
as_root mv        /usr/share/doc/git-2.31.1/technical/{*.,}html           &&

as_root mkdir -vp /usr/share/doc/git-2.31.1/howto/{html,text}             &&
as_root mv        /usr/share/doc/git-2.31.1/howto/{*.txt,text}            &&
as_root mv        /usr/share/doc/git-2.31.1/howto/{*.,}html               &&

sudo sed -i '/^<a href=/s|howto/|&html/|' /usr/share/doc/git-2.31.1/howto-index.html &&
sudo sed -i '/^\* link:/s|howto/|&html/|' /usr/share/doc/git-2.31.1/howto-index.txt &&
${log} `basename "$0"` " installed docs and manpages" blfs_all &&

${log} `basename "$0"` " finished" blfs_all
