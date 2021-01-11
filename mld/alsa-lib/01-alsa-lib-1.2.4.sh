#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/alsa-lib-1.2.4
 then
  rm -rf /sources/alsa-lib-1.2.4
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download https://www.alsa-project.org/files/pub/lib/alsa-lib-1.2.4.tar.bz2 \
    /sources &&

md5sum -c ${SCRIPTPATH}/md5-alsa-lib &&

tar xf /sources/alsa-lib-1.2.4.tar.bz2 -C /sources/ &&

cd /sources/alsa-lib-1.2.4 &&

./configure &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
make doc &&
${log} `basename "$0"` " built" blfs_all &&

as_root make install &&
as_root install -v -d -m755 /usr/share/doc/alsa-lib-1.2.4/html/search &&
as_root install -v -m644 doc/doxygen/html/*.* \
                /usr/share/doc/alsa-lib-1.2.4/html &&
as_root install -v -m644 doc/doxygen/html/search/* \
                /usr/share/doc/alsa-lib-1.2.4/html/search &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
