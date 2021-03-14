#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/lm-sensors-3-6-0
 then
  rm -rf /sources/lm-sensors-3-6-0
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download https://github.com/lm-sensors/lm-sensors/archive/V3-6-0/lm-sensors-3-6-0.tar.gz \
    /sources &&

md5sum -c ${SCRIPTPATH}/md5-lm-sensors &&

tar xf /sources/lm-sensors-3-6-0.tar.gz -C /sources/ &&

cd /sources/lm-sensors-3-6-0 &&


make PREFIX=/usr        \
     BUILD_STATIC_LIB=0 \
     MANDIR=/usr/share/man &&
${log} `basename "$0"` " built" blfs_all &&

as_root make PREFIX=/usr        \
     BUILD_STATIC_LIB=0 \
     MANDIR=/usr/share/man install &&

as_root install -v -m755 -d /usr/share/doc/lm_sensors-3-6-0 &&
as_root cp -rv              README INSTALL doc/* \
                    /usr/share/doc/lm_sensors-3-6-0 &&
${log} `basename "$0"` " installed" blfs_all &&


${log} `basename "$0"` " finished" blfs_all 
