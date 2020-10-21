#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/vlc-3.0.11.1
 then
  rm -rf /sources/vlc-3.0.11.1
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

wget https://download.videolan.org/vlc/3.0.11.1/vlc-3.0.11.1.tar.xz \
    --continue --directory-prefix=/sources &&

md5sum -c ${SCRIPTPATH}/md5-vlc &&

tar xf /sources/vlc-3.0.11.1.tar.xz -C /sources/ &&

cd /sources/vlc-3.0.11.1 &&

sed -i '/vlc_demux.h/a #define LUA_COMPAT_APIINTCASTS' modules/lua/vlc.h   &&
sed -i '/#include <QWidget>/a\#include <QPainterPath>/'            \
    modules/gui/qt/util/timetooltip.hpp                            &&
sed -i '/#include <QPainter>/a\#include <QPainterPath>/'           \
    modules/gui/qt/components/playlist/views.cpp                   \
    modules/gui/qt/dialogs/plugins.cpp                             &&

BUILDCC=gcc ./configure --prefix=/usr    \
                        --disable-opencv \
                        --disable-vdpau  \
                        --disable-vpx  &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
${log} `basename "$0"` " built" blfs_all &&

make check &&
${log} `basename "$0"` " unexpected check succeed" blfs_all
${log} `basename "$0"` " expected check fail?" blfs_all &&

make docdir=/usr/share/doc/vlc-3.0.11.1 install &&
gtk-update-icon-cache -qtf /usr/share/icons/hicolor &&
update-desktop-database -q &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
