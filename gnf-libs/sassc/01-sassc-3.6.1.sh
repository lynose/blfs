#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/sassc-3.6.1
 then
  rm -rf /sources/sassc-3.6.1
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

wget https://github.com/sass/sassc/archive/3.6.1/sassc-3.6.1.tar.gz \
    --continue --directory-prefix=/sources &&#
wget https://github.com/sass/libsass/archive/3.6.4/libsass-3.6.4.tar.gz \
    --continue --directory-prefix=/sources &&

md5sum -c ${SCRIPTPATH}/md5-sassc &&

tar xf /sources/sassc-3.6.1.tar.gz -C /sources/ &&

cd /sources/sassc-3.6.1 &&

tar -xf ../libsass-3.6.4.tar.gz &&
pushd libsass-3.6.4 &&

autoreconf -fi &&

./configure --prefix=/usr --disable-static &&
${log} `basename "$0"` " configured libsass" blfs_all &&

make &&
${log} `basename "$0"` " built libsass" blfs_all &&

make install &&
${log} `basename "$0"` " installed libsass" blfs_all &&

popd &&
autoreconf -fi &&

./configure --prefix=/usr &&
${log} `basename "$0"` " configured sassc" blfs_all &&
make &&
{log} `basename "$0"` " built sassc" blfs_all &&
make install &&
${log} `basename "$0"` " installed sassc" blfs_all &&

${log} `basename "$0"` " finished" blfs_all 
