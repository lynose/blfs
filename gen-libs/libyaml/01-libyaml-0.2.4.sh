#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/libyaml-dist-0.2.4
 then
  rm -rf /sources/libyaml-dist-0.2.4
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

wget https://github.com/yaml/libyaml/archive/0.2.4/libyaml-dist-0.2.4.tar.gz \
    --continue --directory-prefix=/sources &&

md5sum -c ${SCRIPTPATH}/md5-libyaml &&

tar xf /sources/libyaml-dist-0.2.4.tar.gz -C /sources/ &&

cd /sources/libyaml-dist-0.2.4 &&

./bootstrap                                &&
./configure --prefix=/usr --disable-static &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
${log} `basename "$0"` " built" blfs_all &&

make check &&
${log} `basename "$0"` " unexpected check succeed" blfs_all
${log} `basename "$0"` " expected check fail?" blfs_all &&

make install &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
