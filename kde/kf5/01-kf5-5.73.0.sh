#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/kf5
 then
  rm -rf /sources/kf5
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`
mkdir /sources/kf5 &&
cp -u ${SCRIPTPATH}/md5-kf5 /sources/kf5 &&
cd /sources/kf5 &&


url=http://download.kde.org/stable/frameworks/5.73/ &&
wget --continue -r -nH -nd -A '*.xz' -np $url &&
md5sum --ignore-missing -c ./md5-kf5 &&


while read -r line; do

    # Get the file name, ignoring comments and blank lines
    if $(echo $line | grep -E -q '^ *$|^#' ); then continue; fi
    file=$(echo $line | cut -d" " -f2) &&
    
    ${log} `basename "$0"` " ======================================" blfs_all &&
    pkg=$(echo $file|sed 's|^.*/||') &&          # Remove directory
    packagedir=$(echo $pkg|sed 's|\.tar.*||') && # Package directory

    name=$(echo $pkg|sed 's|-5.*$||') && # Isolate package name

    tar -xf $file &&
    pushd $packagedir &&

      case $name in
        kitemviews*) sed -i '/<QList>/a #include <QPersistentModelIndex>' \
          src/kwidgetitemdelegatepool_p.h ;;
        kplotting*) sed -i '/<QHash>/a #include <QHelpEvent>' \
          src/kplotwidget.cpp ;;
        knotifica*) sed -i '/<QUrl>/a #include <QVariant>' \
          src/knotification.h ;;
        kcompleti*) sed -i '/<QClipboard>/a #include <QKeyEvent>' \
          src/klineedit.cpp ;;
        kwayland*) sed -i '/<wayland-xdg-output-server-proto/a #include <QHash>' \
          src/server/xdgoutput_interface.cpp ;;
      esac  

      mkdir build &&
      cd    build &&

      cmake -DCMAKE_INSTALL_PREFIX=$KF5_PREFIX \
            -DCMAKE_PREFIX_PATH=$QT5DIR        \
            -DCMAKE_BUILD_TYPE=Release         \
            -DBUILD_TESTING=OFF                \
            -Wno-dev .. &&
      ${log} `basename "$0"` " configured $packagedir" blfs_all &&
      make &&
      ${log} `basename "$0"` " built $packagedir" blfs_all &&
      as_root make install &&
      ${log} `basename "$0"` " installed $packagedir" blfs_all &&
      ${log} `basename "$0"` " ======================================" blfs_all
    popd

#  as_root rm -rf $packagedir &&
  as_root /sbin/ldconfig
  

done < md5-kf5

as_root rm -f $XORG_PREFIX/bin/xkeystone &&
${log} `basename "$0"` " finished" blfs_all 
