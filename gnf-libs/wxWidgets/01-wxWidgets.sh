#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`
url=https://github.com/wxWidgets/wxWidgets.git
version="v3.1.4"

gitget $url \
        /sources \
        $version &&

pack=`basename ${url}`
packname=${pack:0: -4}
gitpack=/sources/git/${packname}

cd ${gitpack} &&

git submodule update --init 3rdparty/catch &&

if [ -d gtk-build ]
 then
   rm -rf gtk-build
fi

mkdir gtk-build &&
cd gtk-build &&

../configure --with-opengl --with-gtk=3 --prefix=/usr &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
${log} `basename "$0"` " built" blfs_all &&

as_root make install &&
as_root ldconfig &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
