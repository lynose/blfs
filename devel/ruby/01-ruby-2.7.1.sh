#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/ruby-2.7.1
 then
  rm -rf /sources/ruby-2.7.1
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download http://cache.ruby-lang.org/pub/ruby/2.7/ruby-2.7.1.tar.xz \
    /sources &&
    
check_and_download http://www.linuxfromscratch.org/patches/blfs/10.0/ruby-2.7.1-glibc_fix-1.patch \
    /sources &&

md5sum -c ${SCRIPTPATH}/md5-ruby &&

tar xf /sources/ruby-2.7.1.tar.xz -C /sources/ &&

cd /sources/ruby-2.7.1 &&

patch -Np1 -i ../ruby-2.7.1-glibc_fix-1.patch &&

./configure --prefix=/usr   \
            --enable-shared \
            --docdir=/usr/share/doc/ruby-2.7.1 &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
make capi &&
${log} `basename "$0"` " built" blfs_all &&

make check &&
${log} `basename "$0"` " unexpected check succeed" blfs_all
${log} `basename "$0"` " expected check fail?" blfs_all &&

as_root make install &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
