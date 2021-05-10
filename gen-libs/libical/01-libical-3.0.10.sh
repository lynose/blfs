#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/libical-3.0.10
 then
  as_root rm -rf /sources/libical-3.0.10
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download https://github.com/libical/libical/releases/download/v3.0.10/libical-3.0.10.tar.gz \
    /sources &&

md5sum -c ${SCRIPTPATH}/md5-libical &&

tar xf /sources/libical-3.0.10.tar.gz -C /sources/ &&

cd /sources/libical-3.0.10 &&

mkdir build &&
cd    build &&

cmake -DCMAKE_INSTALL_PREFIX=/usr  \
      -DCMAKE_BUILD_TYPE=Release   \
      -DSHARED_ONLY=yes            \
      -DICAL_BUILD_DOCS=true      \
      -DGOBJECT_INTROSPECTION=true \
      -DICAL_GLIB_VAPI=true        \
      ..  &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
make docs &&
${log} `basename "$0"` " built" blfs_all &&



if [ ${ENABLE_TEST} == true ]
 then
  make test &&
  ${log} `basename "$0"` " check succeed" blfs_all ||
  ${log} `basename "$0"` " expected check fail?" blfs_all
fi

as_root make install &&
as_root install -vdm755 /usr/share/doc/libical-3.0.10/html &&
as_root cp -vr apidocs/html/* /usr/share/doc/libical-3.0.10/html &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
