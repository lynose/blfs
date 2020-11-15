#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/which-2.21
 then
  rm -rf /sources/which-2.21
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download https://ftp.gnu.org/gnu/which/which-2.21.tar.gz \
    /sources &&

md5sum -c ${SCRIPTPATH}/md5-which &&

tar xf /sources/which-2.21.tar.gz -C /sources/ &&

cd /sources/which-2.21 &&

./configure --prefix=/usr &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
${log} `basename "$0"` " built" blfs_all &&

as_root make install &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
