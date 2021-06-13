#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/sassc-3.6.2
 then
  as_root rm -rf /sources/sassc-3.6.2
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download https://github.com/sass/sassc/archive/3.6.2/sassc-3.6.2.tar.gz \
    /sources &&#
check_and_download https://github.com/sass/libsass/archive/3.6.5/libsass-3.6.5.tar.gz \
    /sources &&

md5sum -c ${SCRIPTPATH}/md5-sassc &&

tar xf /sources/sassc-3.6.2.tar.gz -C /sources/ &&

cd /sources/sassc-3.6.2 &&

tar -xf ../libsass-3.6.5.tar.gz &&
pushd libsass-3.6.5 &&

autoreconf -fi &&

./configure --prefix=/usr --disable-static &&
${log} `basename "$0"` " configured libsass" blfs_all &&

make &&
${log} `basename "$0"` " built libsass" blfs_all &&

as_root make install &&
${log} `basename "$0"` " installed libsass" blfs_all &&

popd &&
autoreconf -fi &&

./configure --prefix=/usr &&
${log} `basename "$0"` " configured sassc" blfs_all &&
make &&
${log} `basename "$0"` " built sassc" blfs_all &&
as_root make install &&
${log} `basename "$0"` " installed sassc" blfs_all &&

${log} `basename "$0"` " finished" blfs_all 
