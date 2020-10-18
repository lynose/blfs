#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/openjpeg-2.3.1
 then
  rm -rf /sources/openjpeg-2.3.1
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

wget https://github.com/uclouvain/openjpeg/archive/v2.3.1/openjpeg-2.3.1.tar.gz \
    --continue --directory-prefix=/sources &&

md5sum -c ${SCRIPTPATH}/md5-openjpeg-2.3.1.tar.gz &&

tar xf /sources/openjpeg-2.3.1.tar.gz -C /sources/ &&

cd /sources/openjpeg-2.3.1 &&

mkdir -v build &&
cd       build &&

cmake -DCMAKE_BUILD_TYPE=Release \
      -DCMAKE_INSTALL_PREFIX=/usr \
      -DBUILD_STATIC_LIBS=OFF .. &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
${log} `basename "$0"` " built" blfs_all &&

make install &&
pushd ../doc &&
  for man in man/man?/* ; do
      install -v -D -m 644 $man /usr/share/$man
  done 
popd
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
