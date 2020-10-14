#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/Xorg-libs
 then
  rm -rf /sources/Xorg-libs
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`
cp -u ${SCRIPTPATH}/md5-Xorg-libs /sources
mkdir /sources/Xorg-libs &&
cd /sources/Xorg-libs &&


grep -v '^#' ../md5-Xorg-libs | awk '{print $2}' | wget -i- -c \
    -B https://www.x.org/pub/individual/lib/ &&
md5sum -c ../md5-Xorg-libs &&

for package in $(grep -v '^#' ../md5-Xorg-libs | awk '{print $2}' )
do
  ${log} `basename "$0"` " ======================================" blfs_all &&
  packagedir=${package%.tar.bz2}
  tar -xf $package
  pushd $packagedir
  docdir="--docdir=$XORG_PREFIX/share/doc/$packagedir"
  case $packagedir in
    libICE* )
      ./configure $XORG_CONFIG $docdir ICE_LIBS=-lpthread
    ;;

    libXfont2-[0-9]* )
      ./configure $XORG_CONFIG $docdir --disable-devel-docs
    ;;

    libXt-[0-9]* )
      ./configure $XORG_CONFIG $docdir \
                  --with-appdefaultdir=/etc/X11/app-defaults
    ;;

    * )
      ./configure $XORG_CONFIG $docdir
    ;;
  esac
  ${log} `basename "$0"` " configured $package" blfs_all &&
  make &&
  ${log} `basename "$0"` " built $package" blfs_all &&
#   make check 2>&1 | tee ../$packagedir-make_check.log &&
#   ${log} `basename "$0"` " unexpected check succeed $package" blfs_all
#   ${log} `basename "$0"` " expected check fail? $package" blfs_all &&
  as_root make install &&
  ${log} `basename "$0"` " installed $package" blfs_all &&
  popd
  rm -rf $packagedir &&
  as_root /sbin/ldconfig &&
  ${log} `basename "$0"` " ======================================" blfs_all
done

ln -sv $XORG_PREFIX/lib/X11 /usr/lib/X11 &&
ln -sv $XORG_PREFIX/include/X11 /usr/include/X11 &&

${log} `basename "$0"` " finished" blfs_all 
