#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`
cp -u ${SCRIPTPATH}/md5-Xorg-apps /sources &&
mkdir -p /sources/Xorg-apps &&
cd /sources/Xorg-apps &&


grep -v '^#' ../md5-Xorg-apps | awk '{print $2}' | wget -i- -c \
    -B https://www.x.org/pub/individual/app/ &&
md5sum -c ../md5-Xorg-apps &&

for package in $(grep -v '^#' ../md5-Xorg-apps | awk '{print $2}')
do
  ${log} `basename "$0"` " ======================================" blfs_all &&
  packagedir=${package%.tar.?z*} &&
  if [ -d $packagedir ] 
    then
       as_root rm -rf $packagedir
  fi
  
  tar -xf $package &&
  pushd $packagedir
     case $packagedir in
       luit-[0-9]* )
         sed -i -e "/D_XOPEN/s/5/6/" configure
       ;;
     esac
     ./configure $XORG_CONFIG &&
     ${log} `basename "$0"` " configured $package" blfs_all &&
     make &&
     ${log} `basename "$0"` " built $package" blfs_all &&
     as_root make install &&
     ${log} `basename "$0"` " installed $package" blfs_all &&
  popd
  ${log} `basename "$0"` " ======================================" blfs_all
done

as_root rm -f $XORG_PREFIX/bin/xkeystone &&
${log} `basename "$0"` " finished" blfs_all 
