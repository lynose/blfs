#!/bin/bash

${log} `basename "$0"` " started" blfs_all &&

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

if test -d /sources/libusb-1.0.24
 then
  rm -rf /sources/libusb-1.0.24
fi

${log} `basename "$0"` " Downloading" blfs_all &&
check_and_download https://github.com//libusb/libusb/releases/download/v1.0.24/libusb-1.0.24.tar.bz2 \
/sources &&

md5sum -c ${SCRIPTPATH}/md5-libusb &&

tar xf /sources/libusb-1.0.24.tar.bz2 -C /sources/ &&

cd /sources/libusb-1.0.24 &&

sed -i "s/^PROJECT_LOGO/#&/" doc/doxygen.cfg.in &&

./configure --prefix=/usr --disable-static &&
${log} `basename "$0"` " configured" blfs_all &&

make -j1 && 
${log} `basename "$0"` " build" blfs_all &&

sed -i "s/^TCL_SUBST/#&/; s/wide//" doc/doxygen.cfg &&
make -C doc docs &&
${log} `basename "$0"` " build docs" blfs_all &&

as_root make install &&
${log} `basename "$0"` " installed" blfs_all &&

as_root install -v -d -m755 /usr/share/doc/libusb-1.0.24/apidocs &&
as_root install -v -m644    doc/api-1.0/* \
                    /usr/share/doc/libusb-1.0.24/apidocs &&
${log} `basename "$0"` " install apidocs" blfs_all &&

${log} `basename "$0"` " finished" blfs_all
