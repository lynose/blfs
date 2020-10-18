#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/poppler-20.08.0
 then
  rm -rf /sources/poppler-20.08.0
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

wget https://poppler.freedesktop.org/poppler-20.08.0.tar.xz \
    --continue --directory-prefix=/sources &&
wget https://poppler.freedesktop.org/ \
    --continue --directory-prefix=/sources &&

md5sum -c ${SCRIPTPATH}/md5-poppler &&

tar xf /sources/poppler-20.08.0.tar.xz -C /sources/ &&

cd /sources/poppler-20.08.0 &&

mkdir build                         &&
cd    build                         &&

cmake  -DCMAKE_BUILD_TYPE=Release   \
       -DCMAKE_INSTALL_PREFIX=/usr  \
       -DTESTDATADIR=$PWD/testfiles \
       -DENABLE_UNSTABLE_API_ABI_HEADERS=ON     \
       ..  &&
${log} `basename "$0"` " configured" blfs_all &&


make &&
${log} `basename "$0"` " built" blfs_all &&

git clone git://git.freedesktop.org/git/poppler/test testfiles &&
LC_ALL=en_US.UTF-8 make test &&
${log} `basename "$0"` " unexpected check succeed" blfs_all
${log} `basename "$0"` " expected check fail?" blfs_all &&

make install &&
install -v -m755 -d           /usr/share/doc/poppler-20.08.0 &&
cp -vr ../glib/reference/html /usr/share/doc/poppler-20.08.0 &&
tar -xf ../../poppler-data-0.4.9.tar.gz &&
cd poppler-data-0.4.9 &&
make prefix=/usr install &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
