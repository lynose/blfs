#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/libreoffice-7.1.0.3
 then
  rm -rf /sources/libreoffice-7.1.0.3
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download http://download.documentfoundation.org/libreoffice/src/7.1.0/libreoffice-7.1.0.3.tar.xz \
        /sources &&

check_and_download http://download.documentfoundation.org/libreoffice/src/7.1.0/libreoffice-dictionaries-7.1.0.3.tar.xz \
        /sources &&
check_and_download http://download.documentfoundation.org/libreoffice/src/7.1.0/libreoffice-help-7.1.0.3.tar.xz \
        /sources &&
check_and_download http://download.documentfoundation.org/libreoffice/src/7.1.0/libreoffice-translations-7.1.0.3.tar.xz \
        /sources &&
        
md5sum -c ${SCRIPTPATH}/md5-libreoffice &&

tar xf /sources/libreoffice-7.1.0.3.tar.xz --no-overwrite-dir -C /sources/ &&

cd /sources/libreoffice-7.1.0.3 &&
install -dm755 external/tarballs &&
ln -sv /sources/libreoffice-dictionaries-7.1.0.3.tar.xz external/tarballs/ &&
ln -sv /sources/libreoffice-help-7.1.0.3.tar.xz         external/tarballs/ &&
ln -sv /sources/libreoffice-translations-7.1.0.3.tar.xz external/tarballs/

export LO_PREFIX=/opt/libreoffice-7.1.0.3 &&

sed -e "/gzip -f/d"   \
    -e "s|.1.gz|.1|g" \
    -i bin/distro-install-desktop-integration &&

sed -e "/distro-install-file-lists/d" -i Makefile.in &&

export QT5INC=/opt/qt5/include/ &&
export QT5LIB=/opt/qt5/lib/ &&
export KF5INC=/opt/kf5/include/ &&
export KF5LIB=/opt/kf5/include/ &&

./autogen.sh --prefix=$LO_PREFIX         \
             --sysconfdir=/etc           \
             --with-vendor=BLFS          \
             --with-lang=ALL             \
             --with-help                 \
             --with-myspell-dicts        \
             --without-junit             \
             --without-system-dicts      \
             --disable-dconf             \
             --disable-odk               \
             --enable-release-build=yes  \
             --enable-python=system      \
             --with-jdk-home=/opt/jdk    \
             --with-system-apr           \
             --with-system-boost         \
             --with-system-clucene       \
             --with-system-curl          \
             --with-system-epoxy         \
             --with-system-expat         \
             --with-system-glm           \
             --with-system-gpgmepp       \
             --with-system-graphite      \
             --with-system-harfbuzz      \
             --with-system-icu           \
             --with-system-jpeg          \
             --with-system-lcms2         \
             --with-system-libatomic_ops \
             --with-system-libpng        \
             --with-system-libxml        \
             --with-system-neon          \
             --with-system-nss           \
             --with-system-odbc          \
             --with-system-openldap      \
             --with-system-openssl       \
             --with-system-poppler       \
             --with-system-postgresql    \
             --with-system-redland       \
             --with-system-serf          \
             --with-parallelism=$NINJAJOBS \
             --enable-gtk3-kde5          \
             --enable-kf5                \
             --with-system-zlib &&
${log} `basename "$0"` " configured" blfs_all &&

make build-nocheck &&
${log} `basename "$0"` " built" blfs_all &&

as_root make distro-pack-install &&

if [ "$LO_PREFIX" != "/usr" ]; then

  # This symlink is necessary for the desktop menu entries
  as_root ln -svf $LO_PREFIX/lib/libreoffice/program/soffice /usr/bin/libreoffice &&

  # Set up a generic location independent of version number
  as_root ln -sfv libreoffice-7.1.0.3 /opt/libreoffice &&

  # Icons
  as_root mkdir -vp /usr/share/pixmaps &&
  for i in $LO_PREFIX/share/icons/hicolor/32x32/apps/*; do
    as_root ln -svf $i /usr/share/pixmaps
  done &&

  # Desktop menu entries
  for i in $LO_PREFIX/lib/libreoffice/share/xdg/*; do
    as_root ln -svf $i /usr/share/applications/libreoffice-$(basename $i)
  done &&

  # Man pages
  for i in $LO_PREFIX/share/man/man1/*; do
    as_root ln -svf $i /usr/share/man/man1/
  done

  unset i
fi
as_root update-desktop-database &&
unset QT5INC &&
unset QT5LIB &&
unset KF5INC &&
unset KF5LIB &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
