#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/libical-3.0.8
 then
  rm -rf /sources/libical-3.0.8
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

wget https://github.com/libical/libical/releases/download/v3.0.8/libical-3.0.8.tar.gz \
    --continue --directory-prefix=/sources &&

md5sum -c ${SCRIPTPATH}/md5-libical &&

tar xf /sources/libical-3.0.8.tar.gz -C /sources/ &&

cd /sources/libical-3.0.8 &&

mkdir build &&
cd    build &&

cmake -DCMAKE_INSTALL_PREFIX=/usr  \
      -DCMAKE_BUILD_TYPE=Release   \
      -DSHARED_ONLY=yes            \
      -DICAL_BUILD_DOCS=false      \
      -DGOBJECT_INTROSPECTION=true \
      -DICAL_GLIB_VAPI=true        \
      ..  &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
${log} `basename "$0"` " built" blfs_all &&

# make test &&
# ${log} `basename "$0"` " check succeed" blfs_all &&

make install &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
