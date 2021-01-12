#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`
if [ ! -d /sources/kf5 ]
 then
  mkdir /sources/kf5
fi

cp -uf ${SCRIPTPATH}/md5-kf5 /sources/kf5 &&
cd /sources/kf5 &&

url=http://download.kde.org/stable/frameworks/5.77/ &&
wget --continue -r -nH -nd -A '*.xz' -np $url &&
md5sum --ignore-missing -c ./md5-kf5 &&

as_root mv -v /opt/kf5 /opt/kf5.old                         &&
as_root install -v -dm755           $KF5_PREFIX/{etc,share} &&
as_root ln -sfv /etc/dbus-1         $KF5_PREFIX/etc         &&
as_root ln -sfv /usr/share/dbus-1   $KF5_PREFIX/share

while read -r line; do

    # Get the file name, ignoring comments and blank lines
    if $(echo $line | grep -E -q '^ *$|^#' ); then continue; fi
    file=$(echo $line | cut -d" " -f2) &&
    
    ${log} `basename "$0"` " ======================================" blfs_all &&
    pkg=$(echo $file|sed 's|^.*/||') &&          # Remove directory
    packagedir=$(echo $pkg|sed 's|\.tar.*||') && # Package directory
    if test -d $packagedir
     then
      rm -rf $packagedir
    fi
    name=$(echo $pkg|sed 's|-5.*$||') && # Isolate package name

    tar -xf $file &&
    pushd $packagedir &&

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

  as_root rm -rf $packagedir &&
  as_root /sbin/ldconfig
  

done < md5-kf5

as_root mv -v /opt/kf5 /opt/kf5-5.77.0 &&
as_root ln -sfvn kf5-5.77.0 /opt/kf5 &&
${log} `basename "$0"` " finished" blfs_all 