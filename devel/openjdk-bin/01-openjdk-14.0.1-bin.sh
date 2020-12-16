#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/openjdk-14.0.1
 then
  rm -rf /sources/openjdk-14.0.1
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download https://download.java.net/java/GA/jdk14.0.1/664493ef4a6946b186ff29eb326336a2/7/GPL/openjdk-14.0.1_linux-x64_bin.tar.gz \
        /sources

md5sum -c ${SCRIPTPATH}/md5-openjdk &&

tar xf /sources/openjdk-14.0.1_linux-x64_bin.tar.gz -C /sources/ &&

cd /sources/openjdk-14.0.1 &&

as_root install -vdm755 /opt/openjdk-14.0.1 &&
as_root mv -v * /opt/openjdk-14.0.1         &&
as_root chown -R root:root /opt/openjdk-14.0.1

as_root ln -sfn /opt/openjdk-14.0.1 /opt/jdk &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
