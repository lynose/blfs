#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/ffmpeg-4.3.1
 then
  rm -rf /sources/ffmpeg-4.3.1
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download http://ffmpeg.org/releases/ffmpeg-4.3.1.tar.xz \
    /sources &&

md5sum -c ${SCRIPTPATH}/md5-ffmpeg &&

tar xf /sources/ffmpeg-4.3.1.tar.xz -C /sources/ &&

cd /sources/ffmpeg-4.3.1 &&

sed -i 's/-lflite"/-lflite -lasound"/' configure &&

./configure --prefix=/usr        \
            --enable-gpl         \
            --enable-version3    \
            --enable-nonfree     \
            --disable-static     \
            --enable-shared      \
            --disable-debug      \
            --enable-avresample  \
            --enable-libass      \
            --enable-libfdk-aac  \
            --enable-libfreetype \
            --enable-libmp3lame  \
            --enable-libopus     \
            --enable-libtheora   \
            --enable-libvorbis   \
            --enable-libvpx      \
            --enable-libx264     \
            --enable-libx265     \
            --docdir=/usr/share/doc/ffmpeg-4.3.1  &&
${log} `basename "$0"` " configured" blfs_all &&

make &&

gcc tools/qt-faststart.c -o tools/qt-faststart &&
doxygen doc/Doxyfile &&
${log} `basename "$0"` " built" blfs_all &&

as_root make install &&

as_root install -v -m755    tools/qt-faststart /usr/bin &&
as_root install -v -m755 -d           /usr/share/doc/ffmpeg-4.3.1 &&
as_root install -v -m644    doc/*.txt /usr/share/doc/ffmpeg-4.3.1 &&
as_root install -v -m755 -d /usr/share/doc/ffmpeg-4.3.1/api                     &&
as_root cp -vr doc/doxy/html/* /usr/share/doc/ffmpeg-4.3.1/api                  &&
find /usr/share/doc/ffmpeg-4.3.1/api -type f -exec chmod -c 0644 \{} \; &&
find /usr/share/doc/ffmpeg-4.3.1/api -type d -exec chmod -c 0755 \{} \; &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
