#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/boost_1_76_0
 then
  as_root rm -rf /sources/boost_1_76_0
fi


SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download https://boostorg.jfrog.io/artifactory/main/release/1.76.0/source/boost_1_76_0.tar.bz2 \
      /sources


md5sum -c ${SCRIPTPATH}/md5-boost &&

tar xf /sources/boost_1_76_0.tar.bz2 -C /sources/ &&

cd /sources/boost_1_76_0 &&

./bootstrap.sh --prefix=/usr --with-python=python3 &&
${log} `basename "$0"` " configured" blfs_all &&

./b2 stage ${MAKEFLAGS} threading=multi link=shared &&
${log} `basename "$0"` " built" blfs_all &&

if [ ${ENABLE_TEST} == true ]
 then
  pushd tools/build/test; python3 test_all.py; popd &&
  ${log} `basename "$0"` " check succeed" blfs_all ||
  ${log} `basename "$0"` " expected check fail?" blfs_all
fi


if [ ${ENABLE_TEST} == true ]
 then
  pushd status; ../b2; popd &&
  ${log} `basename "$0"` " check2 succeed" blfs_all ||
  ${log} `basename "$0"` " expected check2 fail?" blfs_all
fi
  
as_root ./b2 install threading=multi link=shared &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
