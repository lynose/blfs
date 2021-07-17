#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/ruby-3.0.2
 then
  as_root rm -rf /sources/ruby-3.0.2
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download http://cache.ruby-lang.org/pub/ruby/3.0/ruby-3.0.2.tar.xz \
    /sources &&

md5sum -c ${SCRIPTPATH}/md5-ruby &&

tar xf /sources/ruby-3.0.2.tar.xz -C /sources/ &&

cd /sources/ruby-3.0.2 &&

./configure --prefix=/usr   \
            --enable-shared \
            --docdir=/usr/share/doc/ruby-3.0.2 &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
make capi &&
${log} `basename "$0"` " built" blfs_all &&

if [ ${ENABLE_TEST} == true ]
 then
  make check &&
  ${log} `basename "$0"` " check succeed" blfs_all ||
  ${log} `basename "$0"` " expected check fail?" blfs_all
fi

as_root make install &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
