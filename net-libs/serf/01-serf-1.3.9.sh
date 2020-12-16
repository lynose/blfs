#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/serf-1.3.9
 then
  rm -rf /sources/serf-1.3.9
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download https://archive.apache.org/dist/serf/serf-1.3.9.tar.bz2 \
        /sources


md5sum -c ${SCRIPTPATH}/md5-serf &&

tar xf /sources/serf-1.3.9.tar.bz2 -C /sources/ &&

cd /sources/serf-1.3.9 &&

sed -i "/Append/s:RPATH=libdir,::"          SConstruct &&
sed -i "/Default/s:lib_static,::"           SConstruct &&
sed -i "/Alias/s:install_static,::"         SConstruct &&
sed -i "/  print/{s/print/print(/; s/$/)/}" SConstruct &&
sed -i "/get_contents()/s/,/.decode()&/"    SConstruct &&
${log} `basename "$0"` " configured" blfs_all &&

scons PREFIX=/usr &&
${log} `basename "$0"` " built" blfs_all &&

as_root scons PREFIX=/usr install &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
