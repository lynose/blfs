#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/dejavu-fonts-ttf-2.37
 then
  rm -rf /sources/dejavu-fonts-ttf-2.37
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`
if [ ! -f /sources/dejavu-fonts-ttf-2.37.tar.bz2 ];
 then
  check_and_download https://sourceforge.net/projects/dejavu/files/dejavu/2.37/dejavu-fonts-ttf-2.37.tar.bz2 \
        /sources
fi
# md5sum -c ${SCRIPTPATH}/md5-<basepack> &&

tar xf /sources/dejavu-fonts-ttf-2.37.tar.bz2 -C /sources/ &&

cd /sources/dejavu-fonts-ttf-2.37 &&


as_root install -v -d -m755 /usr/share/fonts/dejavu &&
as_root install -v -m644 ttf/*.ttf /usr/share/fonts/dejavu &&
fc-cache -v /usr/share/fonts/dejavu &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
