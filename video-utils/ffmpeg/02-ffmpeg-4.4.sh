#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/ffmpeg-4.4
 then
  as_root rm -rf /sources/ffmpeg-4.4
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download http://ffmpeg.org/releases/ffmpeg-4.4.tar.xz \
    /sources &&

md5sum -c ${SCRIPTPATH}/md5-ffmpeg &&

tar xf /sources/ffmpeg-4.4.tar.xz -C /sources/ &&

cd /sources/ffmpeg-4.4 &&

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
            --enable-openssl     \
            --enable-libpulse    \
            --enable-libdrm      \
            --docdir=/usr/share/doc/ffmpeg-4.4 &&
${log} `basename "$0"` " configured" blfs_all &&

make &&

gcc tools/qt-faststart.c -o tools/qt-faststart &&

pushd doc &&
for DOCNAME in `basename -s .html *.html`
do
    texi2pdf -b $DOCNAME.texi &&
    texi2dvi -b $DOCNAME.texi &&

    dvips    -o $DOCNAME.ps   \
                $DOCNAME.dvi
done &&
popd &&
unset DOCNAME &&


doxygen doc/Doxyfile &&
${log} `basename "$0"` " built" blfs_all &&

as_root make install &&

as_root install -v -m755    tools/qt-faststart /usr/bin &&
as_root install -v -m755 -d           /usr/share/doc/ffmpeg-4.4 &&
as_root install -v -m644    doc/*.txt /usr/share/doc/ffmpeg-4.4 &&
as_root install -v -m644 doc/*.pdf /usr/share/doc/ffmpeg-4.4 &&
as_root install -v -m644 doc/*.ps  /usr/share/doc/ffmpeg-4.4 &&

as_root install -v -m755 -d /usr/share/doc/ffmpeg-4.4/api                     &&
as_root cp -vr doc/doxy/html/* /usr/share/doc/ffmpeg-4.4/api                  &&
as_root find /usr/share/doc/ffmpeg-4.4/api -type f -exec chmod -c 0644 \{} \; &&
as_root find /usr/share/doc/ffmpeg-4.4/api -type d -exec chmod -c 0755 \{} \; &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
