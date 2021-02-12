#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`
url=https://github.com/libunwind/libunwind.git
version="v1.5-stable"

gitget $url \
        /sources \
        $version &&

pack=`basename ${url}`
packname=${pack:0: -4}
gitpack=/sources/git/${packname}

cd ${gitpack} &&

./autogen.sh &&
./configure --prefix=/usr &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
${log} `basename "$0"` " built" blfs_all &&

if [ ${ENABLE_TEST} == true ]
 then
  make check &&
  ${log} `basename "$0"` " check succeed" blfs_all ||
  ${log} `basename "$0"` " expected check fail?" blfs_all
fi

as_root make install  prefix=/usr &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
