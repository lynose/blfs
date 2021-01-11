#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/mupdf-1.18.0
 then
  rm -rf /sources/mupdf-1.18.0
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download http://www.mupdf.com/downloads/archive/mupdf-1.18.0-source.tar.gz \
    /sources &&

md5sum -c ${SCRIPTPATH}/md5-mupdf &&

tar xf /sources/mupdf-1.18.0-source.tar.gz -C /sources/ &&

cd /sources/mupdf-1.18.0-source &&
sed -i '/MU.*_EXE. :/{
        s/\(.(MUPDF_LIB)\)\(.*\)$/\2 | \1/
        N
        s/$/ -lmupdf -L$(OUT)/
        }' Makefile

cat > user.make << EOF &&
USE_SYSTEM_FREETYPE := yes
USE_SYSTEM_HARFBUZZ := yes
USE_SYSTEM_JBIG2DEC := no
USE_SYSTEM_JPEGXR := no # not used without HAVE_JPEGXR
USE_SYSTEM_LCMS2 := no # need lcms2-art fork
USE_SYSTEM_LIBJPEG := yes
USE_SYSTEM_MUJS := no # build needs source anyways
USE_SYSTEM_OPENJPEG := yes
USE_SYSTEM_ZLIB := yes
USE_SYSTEM_GLUT := no # need freeglut2-art fork
USE_SYSTEM_CURL := yes
USE_SYSTEM_GUMBO := no
EOF

${log} `basename "$0"` " configured" blfs_all &&

export XCFLAGS=-fPIC          &&
make build=release shared=yes &&
unset XCFLAGS

${log} `basename "$0"` " built" blfs_all &&

as_root make prefix=/usr                        \
     shared=yes                         \
     docdir=/usr/share/doc/mupdf-1.18.0 \
     install                            &&

as_root chmod 755 /usr/lib/libmupdf.so          &&
as_root ln -sfv mupdf-x11 /usr/bin/mupdf
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
