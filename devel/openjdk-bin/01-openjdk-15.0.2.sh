#!/bin/bash

${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&

if test -d /sources/jdk-15.0.2
 then
  rm -rf /sources/jdk-15.0.2
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download https://download.java.net/java/GA/jdk15.0.2/0d1cfde4252546c6931946de8db48ee2/7/GPL/openjdk-15.0.2_linux-x64_bin.tar.gz \
        /sources &&

md5sum -c ${SCRIPTPATH}/md5-openjdk &&

if [ -d /opt/jdk-15.0.2-bin ]
 then
  exit 0
fi

tar xf /sources/openjdk-15.0.2_linux-x64_bin.tar.gz -C /sources/ &&

cd /sources/jdk-15.0.2 &&

as_root install -vdm755 /opt/jdk-15.0.2-bin &&
as_root mv -v * /opt/jdk-15.0.2-bin         &&
as_root chown -R root:root /opt/jdk-15.0.2-bin &&

as_root ln -sfn /opt/jdk-15.0.2-bin /opt/jdk &&

${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
