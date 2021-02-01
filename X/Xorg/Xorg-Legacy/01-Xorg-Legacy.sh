#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`
cp -u ${SCRIPTPATH}/md5-Xorg-Legacy /sources &&
mkdir -p /sources/Xorg-Legacy &&
cd /sources/Xorg-Legacy &&


grep -v '^#' ../md5-Xorg-Legacy | awk '{print $2$3}' | wget -i- -c \
     -B https://www.x.org/pub/individual/ &&
grep -v '^#' ../md5-Xorg-Legacy | awk '{print $1 " " $3}' > ../Xorg-Legacy.md5 &&
md5sum -c ../Xorg-Legacy.md5 &&

for package in $(grep -v '^#' ../Xorg-Legacy.md5 | awk '{print $2}')
do
  ${log} `basename "$0"` " ======================================" blfs_all &&
  packagedir=${package%.tar.?z*}
  
  if [ -d $packagedir ]
    then
       as_root rm -rf $packagedir
  fi
  
  
  tar -xf $package &&
  pushd $packagedir &&
     ./configure $XORG_CONFIG &&
     ${log} `basename "$0"` " configured $package" blfs_all &&
     make &&
     ${log} `basename "$0"` " built $package" blfs_all &&
     as_root make install &&
     ${log} `basename "$0"` " installed $package" blfs_all &&
  popd
  ${log} `basename "$0"` " ======================================" blfs_all
done

${log} `basename "$0"` " finished" blfs_all 
