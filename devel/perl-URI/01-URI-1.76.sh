#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/URI-1.76
 then
  rm -rf /sources/URI-1.76
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download https://www.cpan.org/authors/id/O/OA/OALDERS/URI-1.76.tar.gz \
    /sources &&

md5sum -c ${SCRIPTPATH}/md5-URI &&

tar xf /sources/URI-1.76.tar.gz -C /sources/ &&

cd /sources/URI-1.76 &&

perl Makefile.PL &&
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
