#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/graphviz-2.47.0
 then
  rm -rf /sources/graphviz-2.47.0
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download https://gitlab.com/graphviz/graphviz/-/archive/2.47.0/graphviz-2.47.0.tar.gz \
    /sources &&

md5sum -c ${SCRIPTPATH}/md5-graphviz &&

tar xf /sources/graphviz-2.47.0.tar.gz -C /sources/ &&

cd /sources/graphviz-2.47.0 &&

sed -i '/LIBPOSTFIX="64"/s/64//' configure.ac &&

./autogen.sh              &&
./configure --prefix=/usr --disable-php PS2PDF=true &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
${log} `basename "$0"` " built" blfs_all &&

as_root make install &&
as_root ln -vfs /usr/share/graphviz/doc /usr/share/doc/graphviz-2.47.0 &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
