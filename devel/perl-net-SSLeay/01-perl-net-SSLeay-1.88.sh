#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/Net-SSLeay-1.88
 then
  rm -rf /sources/Net-SSLeay-1.88
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download https://cpan.metacpan.org/authors/id/C/CH/CHRISN/Net-SSLeay-1.88.tar.gz \
        /sources


md5sum -c ${SCRIPTPATH}/md5-perl-net-SSLeay &&

tar xf /sources/Net-SSLeay-1.88.tar.gz -C /sources/ &&

cd /sources/Net-SSLeay-1.88 &&

yes '' | perl Makefile.PL &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
${log} `basename "$0"` " built" blfs_all &&

if [ ${ENABLE_TEST} == true ]
 then
  make test &&
  ${log} `basename "$0"` " unexpected check succeed" blfs_all
  ${log} `basename "$0"` " expected check fail?" blfs_all
fi

as_root make install &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
