#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/qtwebengine-everywhere-src-5.15.0
 then
  rm -rf /sources/qtwebengine-everywhere-src-5.15.0
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download https://download.qt.io/archive/qt/5.15/5.15.0/submodules/qtwebengine-everywhere-src-5.15.0.tar.xz \
        /sources
check_and_download http://www.linuxfromscratch.org/patches/blfs/10.0/qtwebengine-everywhere-src-5.15.0-consolidated_fixes-3.patch \
        /sources

md5sum -c ${SCRIPTPATH}/md5-qtwebengine &&

tar xf /sources/qtwebengine-everywhere-src-5.15.0.tar.xz -C /sources/ &&

cd /sources/qtwebengine-everywhere-src-5.15.0 &&

find -type f -name "*.pr[io]" |
  xargs sed -i -e 's|INCLUDEPATH += |&$$QTWEBENGINE_ROOT/include |' &&

patch -Np1 -i ../qtwebengine-everywhere-src-5.15.0-consolidated_fixes-3.patch &&

sed -e '/link_pulseaudio/s/false/true/' \
    -i src/3rdparty/chromium/media/media_options.gni &&
sed -i 's/NINJAJOBS/NINJA_JOBS/' src/core/gn_run.pro &&

if [ -e ${QT5DIR}/lib/libQt5WebEngineCore.so ]; then
  as_root mv -v ${QT5DIR}/lib/libQt5WebEngineCore.so{,.old}
fi

  
mkdir build &&
cd    build &&

qmake .. -- -system-ffmpeg -webengine-icu &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
${log} `basename "$0"` " built" blfs_all &&

as_root make install &&
as_root find $QT5DIR/ -name \*.prl \
   -exec sed -i -e '/^QMAKE_PRL_BUILD_DIR/d' {} \;
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
