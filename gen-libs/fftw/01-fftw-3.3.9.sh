#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/fftw-3.3.9
 then
  rm -rf /sources/fftw-3.3.9
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download http://www.fftw.org/fftw-3.3.9.tar.gz \
    /sources &&

md5sum -c ${SCRIPTPATH}/md5-fftw &&

tar xf /sources/fftw-3.3.9.tar.gz -C /sources/ &&

cd /sources/fftw-3.3.9 &&

./configure --prefix=/usr    \
            --enable-shared  \
            --disable-static \
            --enable-threads \
            --enable-sse2    \
            --enable-avx &&
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

make clean && 
./configure --prefix=/usr    \
            --enable-shared  \
            --disable-static \
            --enable-threads \
            --enable-sse2    \
            --enable-avx     \
            --enable-float &&
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

make clean && 
./configure --prefix=/usr    \
            --enable-shared  \
            --disable-static \
            --enable-threads \
            --enable-long-double &&
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
