#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/texlive-20210325-source
 then
  as_root rm -rf /sources/texlive-20210325-source
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download ftp://tug.org/texlive/historic/2021/texlive-20210325-source.tar.xz \
    /sources &&
check_and_download ftp://tug.org/texlive/historic/2021/texlive-20210325-texmf.tar.xz \
    /sources &&
check_and_download ftp://tug.org/texlive/historic/2021/texlive-20210325-tlpdb-full.tar.gz \
    /sources &&
check_and_download https://www.linuxfromscratch.org/patches/blfs/svn/texlive-20210325-upstream_fixes-1.patch &&
    /sources &&

md5sum -c ${SCRIPTPATH}/md5-texlive &&

tar xf /sources/texlive-20210325-source.tar.xz -C /sources/ &&

cd /sources/texlive-20210325-source &&

cat >> /tmp/tex.conf << EOF &&
# Begin texlive 2021 addition

/opt/texlive/2021/lib

# End texlive 2021 addition
EOF
as_root mv /tmp/tex.conf /etc/ld.so.conf.d/ &&

export TEXARCH=$(uname -m |
 sed -e 's/i.86/i386/' -e 's/$/-linux/')                 &&
patch -Np1 -i ../texlive-20210325-upstream_fixes-1.patch &&

mkdir texlive-build &&
cd texlive-build    &&

../configure                                        \
    --prefix=/opt/texlive/2021                      \
    --bindir=/opt/texlive/2021/bin/$TEXARCH         \
    --datarootdir=/opt/texlive/2021                 \
    --includedir=/opt/texlive/2021/include          \
    --infodir=/opt/texlive/2021/texmf-dist/doc/info \
    --libdir=/opt/texlive/2021/lib                  \
    --mandir=/opt/texlive/2021/texmf-dist/doc/man   \
    --disable-native-texlive-build                  \
    --disable-static --enable-shared                \
    --disable-dvisvgm                               \
    --with-system-cairo                             \
    --with-system-fontconfig                        \
    --with-system-freetype2                         \
    --with-system-gmp                               \
    --with-system-graphite2                         \
    --with-system-harfbuzz                          \
    --with-system-icu                               \
    --with-system-libgs                             \
    --with-system-libpaper                          \
    --with-system-libpng                            \
    --with-system-mpfr                              \
    --with-system-pixman                            \
    --with-system-zlib                              \
    --with-banner-add=" - BLFS" &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
${log} `basename "$0"` " built" blfs_all &&

if [ ${ENABLE_TEST} == true ]
 then
    make -k check &&
    ${log} `basename "$0"` " check succeed" blfs_all ||
    ${log} `basename "$0"` " check failed?" blfs_all
fi

as_root make install-strip &&
as_root /sbin/ldconfig &&
as_root make texlinks &&
as_root mkdir -pv /opt/texlive/2021/tlpkg/TeXLive/ &&
as_root install -v -m644 ../texk/tests/TeXLive/* /opt/texlive/2021/tlpkg/TeXLive/ &&
as_root tar -xf ../../texlive-20210325-tlpdb-full.tar.gz -C /opt/texlive/2021/tlpkg &&
as_root tar -xf ../../texlive-20210325-texmf.tar.xz -C /opt/texlive/2021 --strip-components=1 &&
source /etc/profile.d/extrapathtex.sh &&
as_root /bin/bash -l mktexlsr &&
as_root /bin/bash -l fmtutil-sys --all
as_root mtxrun --generate &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
