#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/Xorg-fonts
 then
  rm -rf /sources/Xorg-fonts
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`
cp -u ${SCRIPTPATH}/md5-Xorg-fonts /sources &&
mkdir /sources/Xorg-fonts &&
cd /sources/Xorg-fonts &&


grep -v '^#' ../md5-Xorg-fonts | awk '{print $2}' | wget -i- -c \
    -B https://www.x.org/pub/individual/font/ &&
md5sum -c ../md5-Xorg-fonts &&

for package in $(grep -v '^#' ../md5-Xorg-fonts | awk '{print $2}')
do
  ${log} `basename "$0"` " ======================================" blfs_all &&
  packagedir=${package%.tar.?z*} &&
  tar -xf $package &&
  pushd $packagedir
     ./configure $XORG_CONFIG &&
     ${log} `basename "$0"` " configured $package" blfs_all &&
     make &&
     ${log} `basename "$0"` " built $package" blfs_all &&
     as_root make install &&
     ${log} `basename "$0"` " installed $package" blfs_all &&
  popd
  as_root rm -rf $packagedir &&
  ${log} `basename "$0"` " ======================================" blfs_all
done

as_root install -v -d -m755 /usr/share/fonts                               &&
as_root ln -svfn $XORG_PREFIX/share/fonts/X11/OTF /usr/share/fonts/X11-OTF &&
as_root ln -svfn $XORG_PREFIX/share/fonts/X11/TTF /usr/share/fonts/X11-TTF &&
${log} `basename "$0"` " finished" blfs_all 
