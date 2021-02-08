#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/rasqal-0.9.33
 then
  rm -rf /sources/rasqal-0.9.33
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download http://download.librdf.org/source/rasqal-0.9.33.tar.gz \
        /sources &&


md5sum -c ${SCRIPTPATH}/md5-rasqal &&

tar xf /sources/rasqal-0.9.33.tar.gz -C /sources/ &&

cd /sources/rasqal-0.9.33 &&

./configure --prefix=/usr --disable-static &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
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
