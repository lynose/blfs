#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/texlive-20200406-source
 then
  rm -rf /sources/texlive-20200406-source
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download ftp://tug.org/texlive/historic/2020/texlive-20200406-source.tar.xz \
    /sources &&
check_and_download ftp://tug.org/texlive/historic/2020/texlive-20200406-texmf.tar.xz \
    /sources &&
check_and_download ftp://tug.org/texlive/historic/2020/texlive-20200406-tlpdb-full.tar.gz \
    /sources &&

md5sum -c ${SCRIPTPATH}/md5-texlive &&

tar xf /sources/texlive-20200406-source.tar.xz -C /sources/ &&

cd /sources/texlive-20200406-source &&

as_root cat >> /etc/ld.so.conf << EOF
# Begin texlive 2020 addition

/opt/texlive/2020/lib

# End texlive 2020 addition
EOF

SYSPOP= &&
MYPOPPLER_MAJOR=$(pkg-config --modversion poppler | cut -d '.' -f1)
if [ "$MYPOPPLER_MAJOR" = "0" ]; then
    # if major was >=20, minor could start with 0 and not fit in octal
    # causing error from 'let' in bash.
    let MYPOPPLER_MINOR=$(pkg-config --modversion poppler | cut -d '.' -f2)
else
    # force a value > 85
    let MYPOPPLER_MINOR=99
fi
if [ "$MYPOPPLER_MINOR" -lt 85 ]; then
    # BLFS-9.1 uses 0.85.0, ignore earlier versions in this script.
    # If updating texlive on an older system, review the available
    # variants for pdftoepdf and pdftosrc to use system poppler.
    SYSPOP=
else
    SYSPOP="--with-system-poppler --with-system-xpdf"
    if [ "$MYPOPPLER_MINOR" -lt 86 ]; then
        mv -v texk/web2c/pdftexdir/pdftoepdf{-poppler0.83.0,}.cc
    else # 0.86.0 or later, including 20.08.0.
        mv -v texk/web2c/pdftexdir/pdftoepdf{-poppler0.86.0,}.cc
    fi
    # For pdftosrc BLFS-9.1 uses 0.83.0 and that is the latest variant.
    mv -v texk/web2c/pdftexdir/pdftosrc{-poppler0.83.0,}.cc
fi &&
export SYSPOP &&
unset MYPOPPLER_{MAJOR,MINOR} &&

export TEXARCH=$(uname -m | sed -e 's/i.86/i386/' -e 's/$/-linux/') &&

mkdir texlive-build &&
cd texlive-build    &&

../configure                                                    \
    --prefix=/opt/texlive/2020                                  \
    --bindir=/opt/texlive/2020/bin/$TEXARCH                     \
    --datarootdir=/opt/texlive/2020                             \
    --includedir=/opt/texlive/2020/include                      \
    --infodir=/opt/texlive/2020/texmf-dist/doc/info             \
    --libdir=/opt/texlive/2020/lib                              \
    --mandir=/opt/texlive/2020/texmf-dist/doc/man               \
    --disable-native-texlive-build                              \
    --disable-static --enable-shared                            \
    --disable-dvisvgm                                           \
    --with-system-cairo                                         \
    --with-system-fontconfig                                    \
    --with-system-freetype2                                     \
    --with-system-gmp                                           \
    --with-system-graphite2                                     \
    --with-system-harfbuzz                                      \
    --with-system-icu                                           \
    --with-system-libgs                                         \
    --with-system-libpaper                                      \
    --with-system-libpng                                        \
    --with-system-mpfr                                          \
    --with-system-pixman                                        \
    ${SYSPOP}                                                   \
    --with-system-zlib                                          \
    --with-banner-add=" - BLFS" &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
unset SYSPOP &&
${log} `basename "$0"` " built" blfs_all &&

make -k check &&
${log} `basename "$0"` " check succeed" blfs_all ||
${log} `basename "$0"` " expected check fail?" blfs_all &&

as_root make install-strip &&
/sbin/ldconfig &&
make texlinks &&
as_root mkdir -pv /opt/texlive/2020/tlpkg/TeXLive/ &&
as_root install -v -m644 ../texk/tests/TeXLive/* /opt/texlive/2020/tlpkg/TeXLive/ &&
tar -xf ../../texlive-20200406-tlpdb-full.tar.gz -C /opt/texlive/2020/tlpkg &&
tar -xf ../../texlive-20200406-texmf.tar.xz -C /opt/texlive/2020 --strip-components=1 &&
source /etc/profile.d/extrapaths.sh &&
mktexlsr &&
fmtutil-sys --all
mtxrun --generate &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
