#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/glm-0.9.9.8
 then
  rm -rf /sources/glm-0.9.9.8
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download https://github.com/g-truc/glm/archive/0.9.9.8/glm-0.9.9.8.tar.gz \
        /sources &&


md5sum -c ${SCRIPTPATH}/md5-glm &&

tar xf /sources/glm-0.9.9.8.tar.gz -C /sources/ &&

cd /sources/glm-0.9.9.8 &&

as_root cp -r glm /usr/include/ &&
as_root cp -r doc /usr/share/doc/glm-0.9.9.8 &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
