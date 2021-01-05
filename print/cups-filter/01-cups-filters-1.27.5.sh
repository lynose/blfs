#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/cups-filters-1.27.5
 then
  rm -rf /sources/cups-filters-1.27.5
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download https://www.openprinting.org/download/cups-filters/cups-filters-1.27.5.tar.xz \
    /sources &&

md5sum -c ${SCRIPTPATH}/md5-cups-filters &&

tar xf /sources/cups-filters-1.27.5.tar.xz -C /sources/ &&

cd /sources/cups-filters-1.27.5 &&

sed -i "s:cups.service:org.cups.cupsd.service:g" utils/cups-browsed.service &&

./configure --prefix=/usr        \
            --sysconfdir=/etc    \
            --localstatedir=/var \
            --without-rcdir      \
            --disable-static     \
            --disable-avahi      \
            --docdir=/usr/share/doc/cups-filters-1.27.5 &&
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
as_root install -v -m644 utils/cups-browsed.service /lib/systemd/system/cups-browsed.service &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
