#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/apache-ant-1.10.9
 then
  rm -rf /sources/apache-ant-1.10.9
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download https://archive.apache.org/dist/ant/source/apache-ant-1.10.9-src.tar.xz \
        /sources &&


md5sum -c ${SCRIPTPATH}/md5-apache-ant &&

tar xf /sources/apache-ant-1.10.9-src.tar.xz -C /sources/ &&

cd /sources/apache-ant-1.10.9 &&

sed -i 's/--add-modules java.activation/-html4/' build.xml &&
./bootstrap.sh &&
bootstrap/bin/ant -f fetch.xml -Ddest=optional &&
${log} `basename "$0"` " configured" blfs_all &&

./build.sh -Ddist.dir=$PWD/ant-1.10.9 dist &&
${log} `basename "$0"` " built" blfs_all &&

as_root cp -rv ant-1.10.9 /opt/            &&
as_root chown -R root:root /opt/ant-1.10.9 &&
as_root ln -sfv ant-1.10.9 /opt/ant &&

cat > ./ant.sh << EOF &&
# Begin /etc/profile.d/ant.sh

pathappend /opt/ant/bin
export ANT_HOME=/opt/ant

# End /etc/profile.d/ant.sh
EOF

as_root mv -v ./ant.sh /etc/profile.d/ant.sh &&
as_root chown -v root:root /etc/profile.d/ant.sh &&

${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
