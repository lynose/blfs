#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/pidgin-2.14.1
 then
  as_root rm -rf /sources/pidgin-2.14.1
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download https://downloads.sourceforge.net/pidgin/pidgin-2.14.1.tar.bz2 \
        /sources &&


md5sum -c ${SCRIPTPATH}/md5-pidgin &&

tar xf /sources/pidgin-2.14.1.tar.bz2 -C /sources/ &&

cd /sources/pidgin-2.14.1 &&

./configure --prefix=/usr        \
            --sysconfdir=/etc    \
            --enable-cyrus-sasl  \
            --disable-gstreamer  \
            --disable-gtkspell   \
            --disable-meanwhile  \
            --disable-idn        \
            --disable-vv &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
make docs &&
${log} `basename "$0"` " built" blfs_all &&

# if [ ${ENABLE_TEST} == true ] #TODO need libidn
#  then
#   make check &&
#   ${log} `basename "$0"` " check succeed" blfs_all ||
#   ${log} `basename "$0"` " expected check fail?" blfs_all
# fi

as_root make install &&
as_root mkdir -pv /usr/share/doc/pidgin-2.14.1 &&
as_root cp -v README doc/gtkrc-2.0 /usr/share/doc/pidgin-2.14.1 &&
as_root mkdir -pv /usr/share/doc/pidgin-2.14.1/api &&
as_root cp -v doc/html/* /usr/share/doc/pidgin-2.14.1/api &&
as_root gtk-update-icon-cache -qtf /usr/share/icons/hicolor &&
as_root update-desktop-database -q &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
