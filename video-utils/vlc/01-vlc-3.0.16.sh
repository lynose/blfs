#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/vlc-3.0.16
 then
   as_root rm -rf /sources/vlc-3.0.16
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download https://download.videolan.org/vlc/3.0.16/vlc-3.0.16.tar.xz \
    /sources &&

md5sum -c ${SCRIPTPATH}/md5-vlc &&

tar xf /sources/vlc-3.0.16.tar.xz -C /sources/ &&

cd /sources/vlc-3.0.16 &&

export LUAC=/usr/bin/luac5.2                   &&
export LUA_LIBS="$(pkg-config --libs lua52)"   &&
export CPPFLAGS="$(pkg-config --cflags lua52)" &&

BUILDCC=gcc ./configure --prefix=/usr    \
                        --disable-opencv \
                        --disable-vpx    &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
${log} `basename "$0"` " built" blfs_all &&

if [ ${ENABLE_TEST} == true ]
 then
  make check &&
  ${log} `basename "$0"` " check succeed" blfs_all ||
  ${log} `basename "$0"` " expected check fail?" blfs_all
fi

as_root make docdir=/usr/share/doc/vlc-3.0.16 install &&
as_root gtk-update-icon-cache -qtf /usr/share/icons/hicolor &&
as_root update-desktop-database -q &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
