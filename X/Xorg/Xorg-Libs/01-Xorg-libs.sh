#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

cp -u ${SCRIPTPATH}/md5-Xorg-libs /sources &&
mkdir -p /sources/Xorg-libs &&
cd /sources/Xorg-libs &&


grep -v '^#' ../md5-Xorg-libs | awk '{print $2}' | wget -i- -c \
    -B https://www.x.org/pub/individual/lib/ &&
md5sum -c ../md5-Xorg-libs &&

for package in $(grep -v '^#' ../md5-Xorg-libs | awk '{print $2}' )
do
  ${log} `basename "$0"` " ======================================" blfs_all &&
  
  packagedir=${package%.tar.?z*}
  
  if [ -d $packagedir ];
    then
       as_root rm -rf $packagedir
  fi
  
  tar -xf $package &&
  pushd $packagedir &&
  docdir="--docdir=$XORG_PREFIX/share/doc/$packagedir" &&
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
  if [ ${ENABLE_TEST} == true ]
   then
    make check 2>&1 | tee /log/$packagedir-make_check.log &&
    ${log} `basename "$0"` " check succeed" blfs_all ||
    ${log} `basename "$0"` " expected check fail?" blfs_all
  fi
  as_root make install &&
  ${log} `basename "$0"` " installed $package" blfs_all &&
  popd
  as_root /sbin/ldconfig &&
  ${log} `basename "$0"` " ======================================" blfs_all
done

${log} `basename "$0"` " finished" blfs_all 
