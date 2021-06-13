#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/thunderbird-78.11.0
 then
  as_root rm -rf /sources/thunderbird-78.11.0
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download https://archive.mozilla.org/pub/thunderbird/releases/78.11.0/source/thunderbird-78.11.0.source.tar.xz \
        /sources &&


md5sum -c ${SCRIPTPATH}/md5-thunderbird &&

tar xf /sources/thunderbird-78.11.0.source.tar.xz -C /sources/

cd /sources/thunderbird-78.11.0 &&

cat > mozconfig << "EOF" &&
# If you have a multicore machine, all cores will be used.

# If you have installed wireless-tools comment out this line:
#ac_add_options --disable-necko-wifi

# Uncomment the following option if you have not installed PulseAudio
#ac_add_options --disable-pulseaudio
# and uncomment this if you installed alsa-lib instead of PulseAudio
#ac_add_options --enable-alsa

# Comment out following options if you have not installed
# recommended dependencies:
ac_add_options --with-system-libevent
ac_add_options --with-system-nspr
ac_add_options --with-system-nss
ac_add_options --with-system-icu

# The elf-hack causes failed builds on clang-9.0.1 with some CFLAGS including
# -march=native on Ryzen. It is supposed to improve startup time and it shrinks
# libxul.so by a few MB - Uncomment this if your build is affected.
ac_add_options --disable-elf-hack

# The BLFS editors recommend not changing anything below this line:
ac_add_options --prefix=/usr
ac_add_options --enable-application=comm/mail

ac_add_options --disable-crashreporter
ac_add_options --disable-updater
ac_add_options --disable-debug
ac_add_options --disable-debug-symbols
ac_add_options --disable-tests

ac_add_options --enable-optimize=-O2
ac_add_options --enable-linker=gold
ac_add_options --enable-strip
ac_add_options --enable-install-strip

ac_add_options --enable-official-branding

ac_add_options --enable-system-ffi
ac_add_options --enable-system-pixman

ac_add_options --with-system-jpeg
ac_add_options --with-system-png
ac_add_options --with-system-zlib
EOF

${log} `basename "$0"` " configured" blfs_all &&

export CC=gcc CXX=g++ &&
./mach configure &&
./mach build &&
${log} `basename "$0"` " built" blfs_all &&

as_root ./mach install &&

as_root mkdir -pv /usr/share/{applications,pixmaps} &&

cat > /tmp/thunderbird.desktop << "EOF" &&
[Desktop Entry]
Name=Thunderbird Mail
Comment=Send and receive mail with Thunderbird
GenericName=Mail Client
Exec=thunderbird %u
Terminal=false
Type=Application
Icon=thunderbird
Categories=Network;Email;
MimeType=application/xhtml+xml;text/xml;application/xhtml+xml;application/xml;application/rss+xml;x-scheme-handler/mailto;
StartupNotify=true
EOF

as_root mv /tmp/thunderbird.desktop /usr/share/applications/thunderbird.desktop &&
as_root chown root:root /usr/share/applications/thunderbird.desktop &&
as_root ln -sfv /usr/lib/thunderbird/chrome/icons/default/default256.png \
        /usr/share/pixmaps/thunderbird.png &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
