#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/graphviz-2.44.1
 then
  rm -rf /sources/graphviz-2.44.1
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

wget https://www2.graphviz.org/Packages/stable/portable_source/graphviz-2.44.1.tar.gz \
    --continue --directory-prefix=/sources &&

md5sum -c ${SCRIPTPATH}/md5-graphviz &&

tar xf /sources/graphviz-2.44.1.tar.gz -C /sources/ &&

cd /sources/graphviz-2.44.1 &&

sed -i '/LIBPOSTFIX="64"/s/64//' configure.ac &&

autoreconf                            &&
./configure --prefix=/usr PS2PDF=true &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
${log} `basename "$0"` " built" blfs_all &&

make install &&
ln -v -s /usr/share/graphviz/doc /usr/share/doc/graphviz-2.44.1 &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
