#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/firefox-78.2.0
 then
  rm -rf /sources/firefox-78.2.0
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download https://archive.mozilla.org/pub/firefox/releases/78.2.0esr/source/firefox-78.2.0esr.source.tar.xz \
    /sources &&

md5sum -c ${SCRIPTPATH}/md5-firefox &&


tar xf /sources/firefox-78.2.0esr.source.tar.xz -C /sources/

cd /sources/firefox-78.2.0 &&

cat > mozconfig << "EOF"
# If you have a multicore machine, all cores will be used by default.

# If you have installed (or will install) wireless-tools, and you wish
# to use geolocation web services, comment out this line
ac_add_options --disable-necko-wifi

# API Keys for geolocation APIs - necko-wifi (above) is required for MLS
# Uncomment the following line if you wish to use Mozilla Location Service
#ac_add_options --with-mozilla-api-keyfile=$PWD/mozilla-key

# Uncomment the following line if you wish to use Google's geolocaton API
# (needed for use with saved maps with Google Maps)
#ac_add_options --with-google-location-service-api-keyfile=$PWD/google-key

# startup-notification is required since firefox-78

# Uncomment the following option if you have not installed PulseAudio
#ac_add_options --disable-pulseaudio
# or uncomment this if you installed alsa-lib instead of PulseAudio
#ac_add_options --enable-alsa

# Comment out following options if you have not installed
# recommended dependencies:
ac_add_options --with-system-libevent
ac_add_options --with-system-webp
ac_add_options --with-system-nspr
ac_add_options --with-system-nss
ac_add_options --with-system-icu

# Do not specify the gold linker which is not the default. It will take
# longer and use more disk space when debug symbols are disabled.

# libdavid (av1 decoder) requires nasm. Uncomment this if nasm
# has not been installed.
#ac_add_options --disable-av1

# You cannot distribute the binary if you do this
ac_add_options --enable-official-branding

# Stripping is now enabled by default.
# Uncomment these lines if you need to run a debugger:
#ac_add_options --disable-strip
#ac_add_options --disable-install-strip

# Disabling debug symbols makes the build much smaller and a little
# faster. Comment this if you need to run a debugger. Note: This is
# required for compilation on i686.
ac_add_options --disable-debug-symbols

# The elf-hack is reported to cause failed installs (after successful builds)
# on some machines. It is supposed to improve startup time and it shrinks
# libxul.so by a few MB - comment this if you know your machine is not affected.
ac_add_options --disable-elf-hack

# The BLFS editors recommend not changing anything below this line:
ac_add_options --prefix=/usr
ac_add_options --enable-application=browser
ac_add_options --disable-crashreporter
ac_add_options --disable-updater
# enabling the tests will use a lot more space and significantly
# increase the build time, for no obvious benefit.
ac_add_options --disable-tests

# The default level of optimization again produces a working build with gcc.
ac_add_options --enable-optimize

ac_add_options --enable-system-ffi
ac_add_options --enable-system-pixman

# --with-system-bz2 was removed in firefox-78
ac_add_options --with-system-jpeg
ac_add_options --with-system-png
ac_add_options --with-system-zlib

# The following option unsets Telemetry Reporting. With the Addons Fiasco,
# Mozilla was found to be collecting user's data, including saved passwords and
# web form data, without users consent. Mozilla was also found shipping updates
# to systems without the user's knowledge or permission.
# As a result of this, use the following command to permanently disable
# telemetry reporting in Firefox.
unset MOZ_TELEMETRY_REPORTING

mk_add_options MOZ_OBJDIR=@TOPSRCDIR@/firefox-build-dir
EOF

sed -i -e 's/Disable/Enable/'      \
 -e '/^MOZ_REQUIRE_SIGNING/s/0/1/' \
 build/mozconfig.common &&
${log} `basename "$0"` " configured" blfs_all &&

export CC=gcc CXX=g++ &&
export MOZBUILD_STATE_PATH=${PWD}/mozbuild &&
./mach build &&
${log} `basename "$0"` " built" blfs_all &&

as_root ./mach install                                                  &&

as_root mkdir -pv  /usr/lib/mozilla/plugins                             &&
as_root ln    -sfv ../../mozilla/plugins /usr/lib/firefox/browser/ &&
unset CC CXX MOZBUILD_STATE_PATH &&

as_root mkdir -pv /usr/share/applications &&
as_root mkdir -pv /usr/share/pixmaps &&

cat > ./firefox.desktop << "EOF" &&
[Desktop Entry]
Encoding=UTF-8
Name=Firefox Web Browser
Comment=Browse the World Wide Web
GenericName=Web Browser
Exec=firefox %u
Terminal=false
Type=Application
Icon=firefox
Categories=GNOME;GTK;Network;WebBrowser;
MimeType=application/xhtml+xml;text/xml;application/xhtml+xml;application/vnd.mozilla.xul+xml;text/mml;x-scheme-handler/http;x-scheme-handler/https;
StartupNotify=true
EOF

as_root mv -v ./firefox.desktop /usr/share/applications/firefox.desktop &&

as_root ln -sfv /usr/lib/firefox/browser/chrome/icons/default/default128.png \
        /usr/share/pixmaps/firefox.png &&

${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
