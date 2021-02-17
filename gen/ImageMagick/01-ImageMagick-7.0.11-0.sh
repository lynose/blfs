#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/ImageMagick-7.0.11-0
 then
  rm -rf /sources/ImageMagick-7.0.11-0
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download https://www.imagemagick.org/download/releases/ImageMagick-7.0.11-0.tar.xz \
        /sources &&


md5sum -c ${SCRIPTPATH}/md5-ImageMagick &&

tar xf /sources/ImageMagick-7.0.11-0.tar.xz -C /sources/ &&

cd /sources/ImageMagick-7.0.11-0 &&

./configure --prefix=/usr     \
            --sysconfdir=/etc \
            --enable-hdri     \
            --with-modules    \
            --with-perl       \
            --with-gslib      \
            --with-rsvg       \
            --with-gvc        \
            --with-dejavu-font-dir=/usr/share/fonts/dejavu \
            --disable-static  &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
${log} `basename "$0"` " built" blfs_all &&

as_root make DOCUMENTATION_PATH=/usr/share/doc/imagemagick-7.0.11 install &&
if [ ${ENABLE_TEST} == true ]
 then
  make tests/validate &&
  tests/validate 2>&1 | tee /log/validate.log &&
  make check &&
  ${log} `basename "$0"` " check succeed" blfs_all ||
  ${log} `basename "$0"` " expected check fail?" blfs_all
fi
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
