#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/liblinear-241
 then
  rm -rf /sources/liblinear-241
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download https://github.com/cjlin1/liblinear/archive/v241/liblinear-241.tar.gz \
        /sources


md5sum -c ${SCRIPTPATH}/md5-liblinear &&

tar xf /sources/liblinear-241.tar.gz -C /sources/ &&

cd /sources/liblinear-241 &&

make lib &&
${log} `basename "$0"` " built" blfs_all &&


as_root install -vm644 linear.h /usr/include &&
as_root install -vm755 liblinear.so.4 /usr/lib &&
as_root ln -sfv liblinear.so.4 /usr/lib/liblinear.so &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
