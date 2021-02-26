#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/vulkan
 then
  as_root rm -rf /sources/vulkan
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

# check_and_download <link> \
#         /sources &&

#md5sum -c ${SCRIPTPATH}/md5-<basepack> &&

mkdir -p /sources/vulkan &&
tar xf /sources/vulkansdk-linux-x86_64-1.2.162.1.tar.gz -C /sources/vulkan &&

cd /sources/vulkan/1.2.162.1 &&

./vulkansdk all &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
${log} `basename "$0"` " built" blfs_all &&

if [ ${ENABLE_TEST} == true ]
 then
  make check &&
  ${log} `basename "$0"` " check succeed" blfs_all ||
  ${log} `basename "$0"` " expected check fail?" blfs_all
fi

as_root make install &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
