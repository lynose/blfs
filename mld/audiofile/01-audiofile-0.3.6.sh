#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/audiofile-0.3.6
 then
  rm -rf /sources/audiofile-0.3.6
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download http://ftp.gnome.org/pub/gnome/sources/audiofile/0.3/audiofile-0.3.6.tar.xz \
        /sources


md5sum -c ${SCRIPTPATH}/md5-audiofile &&

tar xf /sources/audiofile-0.3.6.tar.xz -C /sources/ &&

cd /sources/audiofile-0.3.6 &&

CXXFLAGS=-std=c++98 \
./configure --prefix=/usr --disable-static &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
${log} `basename "$0"` " built" blfs_all &&

as_root make install &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
