#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/fdk-aac-2.0.1
 then
  rm -rf /sources/fdk-aac-2.0.1
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

if [ ! -f /sources/fdk-aac-2.0.1.tar.gz ];  
 then
  wget https://downloads.sourceforge.net/opencore-amr/fdk-aac-2.0.1.tar.gz \
    --continue --directory-prefix=/sources
fi

md5sum -c ${SCRIPTPATH}/md5-fdk-aac &&

tar xf /sources/fdk-aac-2.0.1.tar.gz -C /sources/ &&

cd /sources/fdk-aac-2.0.1 &&

./configure --prefix=/usr --disable-static &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
${log} `basename "$0"` " built" blfs_all &&

make install &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
