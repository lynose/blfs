#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/alsa-tools-1.2.5
 then
  rm -rf /sources/alsa-tools-1.2.5
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download https://www.alsa-project.org/files/pub/tools/alsa-tools-1.2.5.tar.bz2 \
    /sources &&

md5sum -c ${SCRIPTPATH}/md5-alsa-tools &&

tar xf /sources/alsa-tools-1.2.5.tar.bz2 -C /sources/ &&

cd /sources/alsa-tools-1.2.5 &&

rm -rf qlo10k1 Makefile gitcompile &&

for tool in *
do
  case $tool in
    seq )
      tool_dir=seq/sbiload
    ;;
    * )
      tool_dir=$tool
    ;;
  esac

  pushd $tool_dir
    
    ./configure --prefix=/usr &&
    ${log} `basename "$0"` " configured $tool_dir" blfs_all &&
    make &&
    ${log} `basename "$0"` " built $tool_dir" blfs_all &&
    as_root make install &&
    as_root /sbin/ldconfig &&
    ${log} `basename "$0"` " installed $tool_dir" blfs_all &&
  popd

done
unset tool tool_dir &&

${log} `basename "$0"` " finished" blfs_all 
