#!/bin/bash

as_root()
{
  if   [ $EUID = 0 ];        then $*
  elif [ -x /usr/bin/sudo ]; then sudo $*
  else                            su -c \\"$*\\"
  fi
}

export -f as_root

#############################################################################
#
#   Global Xorg configuration
#
#############################################################################
#./X/Xorg/01preXorg.sh &&
source /etc/profile.d/xorg.sh && # Do not uncomment

${log} `basename "$0"` " started" blfs_all &&
${log} `basename "$0"` " ======================================" blfs_all &&
${log} `basename "$0"`  "Started BLFS build" &&
${log} `basename "$0"` " ======================================" blfs_all &&
${log} `basename "$0"` "                                       " blfs_all &&
${log} `basename "$0"` "                                       " blfs_all &&
#############################################################################
#
#   Packages without required and recommended dependencies
#
#############################################################################
# ./gen-libs/libxml2/01-libxml2-2.9.10.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./sys/unzip/01-unzip60.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./sgml/sgml-common/01-sgml-common-0.6.3.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./gen-libs/libuv/01-libuv-v1.18.1.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./gen-libs/libarchive/01-libarchive-3.4.3.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./sys/which/01-which-2.21.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./gen-libs/libssh2/01-libssh2-1.9.0.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./net-libs/libtirpc/01-libtirpc-1.2.6.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./gnf-libs/libpng/01-libpng-1.6.37.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./sys/acpid/01-acpid-2.0.32.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./sys/LSB-Tools/01-LSB-Tools-0.7.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./devel/autoconf-old/01-autoconf-2.13.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./devel/python2/01-python2-2.7.18.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./X/util-macros/01-util-macros-1.19.2.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
./gen-libs/mtdev/01-mtdev-1.1.6.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
./devel/yasm/01-yasm-1.3.0.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
./devel/nasm/01-nasm-2.15.03.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
./mld/fdk-aac/01-fdk-aac-2.0.1.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
# ./sec/cracklib/01-cracklib-2.9.7.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./sec/Linux-PAM/01-Linux-PAM-1.4.0.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
./mld/libogg/01-libogg-1.3.4.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
./audio-utils/lame/01-lame-3.100.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
./gnf-libs/frididi/01-fribidi-1.0.9.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&

#############################################################################
#
#   Packages with required or recommended dependencies
#
#############################################################################
# ./devel/MarkupSafe/01-MarkupSafe-1.1.1.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./devel/Mako/01-Mako-1.1.3.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./gen/lsof/01-lsof-4.91.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./gnf-libs/freetype/01-freetype-2.10.2.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./xml/docbook-xsl-nons/01-docbook-xsl-nons-1.79.2.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./xml/docbook-xml/01-docbook-xml-4.5.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./gen-libs/libxslt/01-libxslt-1.1.34.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
./xml/xmlto/01-xmlto-0.0.28.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
./gen/asciidoc/01-asciidoc-9.0.2.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
# ./sys/pciutils/01-pciutils-3.7.0.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./net-libs/curl/01-curl-7.71.1.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./devel/git/01-git-2.28.0.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./net-libs/nghttp2/01-nghttp2-1.41.0.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./devel/cmake/01-cmake-3.18.1.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
./mld/x265/01-x265-3.4.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
./mld/x264/01-x264-20200819.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
# ./gnf-libs/graphite2/01-graphite2-1.3.14.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./gen-libs/json-c/01-json-c-0.15.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./devel/doxygen/01-doxygen-1.8.19.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
./mld/opus/01-opus-1.3.1.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
./mld/libvpx/01-libvpx-1.9.0.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
./mld/libvorbis/01-libvorbis-1.3.7.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
# ./gen-libs/libusb/01-libusb-1.0.23.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./sys/usbutils/01-usbutils-012.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./sys/lm-sensors/01-lm-sensors-3-6-0.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./gen-libs/boost/01-boost_1_74_0.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./devel/llvm/01-llvm-10.0.1.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./gen-libs/JS/01-JS-68.11.0.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./gen-libs/pcre/01-pcre-8.44.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./gen-libs/glib/01-glib-2.64.4.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./gen-libs/icu/01-icu-67.1.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./gnf-libs/harfbuzz/01-harfbuzz-2.7.1.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./gnf-libs/freetype/02-freetype-2.10.2.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./gnf-libs/fontconfig/01-fontconfig-2.13.1.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
./mld/libass/01-libass-0.14.0.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
# ./sec/polkit/01-polkit-0.117.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./sys/systemd/01-systemd-246.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./sec/libpwquality/01-libpwquality-1.4.2.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./sec/shadow/01-shadow-4.8.1.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./mld/alsa-lib/01-alsa-lib-1.2.3.2.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./mld/alsa-plugin/01-alsa-plugin-1.2.2.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./mld/alsa-utils/01-alsa-utils-1.2.3.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./mld/alsa-firmware/01-alsa-firmware-1.2.1.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./mld/alsa-oss/01-alsa-oss-1.1.8.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
./mld/SDL2/01-SDL2-2.0.12.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
./mld/libtheora/01-libtheora-1.1.1.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
./video-utils/ffmpeg/01-ffmpeg-4.3.1.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
# ./gen-libs/wayland/01-wayland-1.18.0.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./gen-libs/wayland-protocols/01-wayland-protocols-1.20.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./X/xorgproto/01-xorgproto-2020.1.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./X/libXau/01-libXau-1.0.9.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./X/xcb-proto/01-xcb-proto-1.14.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./X/libXdmcp/01-libXdmcp-1.1.3.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./X/libxcb/01-libxcb-1.14.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./X/Xorg/Xorg-Libs/01-Xorg-libs.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./sys/dbus/01-dbus-1.12.20.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./X/xcb-util/01-xcb-util-0.4.0.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./X/xcb-util-image/01-xcb-util-image-0.4.0.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./X/xcb-util-keysyms/01-xcb-util-keysyms-0.4.0.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./X/xcb-util-renderutil/01-xcb-util-renderutil-0.3.9.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./X/xcb-util-wm/01-xcb-util-wm-0.4.1.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./X/xcb-util-cursor/01-xcb-util-cursor-0.1.3.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./X/libdrm/01-libdrm-2.4.102.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./X/Xorg/Xorg-drivers/libva/01-libva-2.8.0.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&

./X/Xorg/Xorg-drivers/libvdpau/01-libvdpau-1.4.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
./X/Xorg/Xorg-drivers/libvdpau-va-gl/01-libvdpau-va-gl-0.4.0.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
./X/mesa/01-mesa-20.1.5.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
# ./X/Xorg/Xorg-drivers/libva/01-libva-2.8.0.sh && # Rebuild after mesa
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./X/xbitmaps/01-xbitmaps-1.1.2.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./X/Xorg/Xorg-apps/01-Xorg-apps.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./X/xcursor-themes/01-xcursor-themes-1.0.6.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./X/Xorg/Xorg-Fonts/01-Xorg-fonts.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
./X/xkeyboard-config/01-xkeyboard-config-2.30.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
./gnf-libs/pixman/01-pixman-0.40.0.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
./X/libepoxy/01-libepoxy-1.5.4.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
./X/Xorg/Xorg-server/01-xorg-server-1.20.8.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
./X/Xorg/Xorg-drivers/libevdev/01-libevdev-1.9.1.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
./X/Xorg/Xorg-drivers/xf86-input-evdev/01-x86-input-evdev-2.10.6.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
./X/Xorg/Xorg-drivers/libinput/01-libinput-1.16.1.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
./X/Xorg/Xorg-drivers/xf86-input-libinput/01-xf86-input-libinput-0.30.0.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
./X/Xorg/Xorg-drivers/xf86-video-amdgpu/01-xf86-video-amdgpu-19.1.0.sh    &&
${log} `basename "$0"` " ======================================" blfs_all &&
./X/Xorg/Xorg-drivers/xf86-video-fbdev/01-xf86-video-fbdev-0.5.0.sh       &&
${log} `basename "$0"` " ======================================" blfs_all &&
./X/Xorg/Xorg-Legacy/01-Xorg-Legacy.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
./X/twm/01-twm-1.0.11.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
./X/dejavu-fonts/01-dejavu-fonts-2.37.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
./X/xterm/01-xterm-359.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
./X/xclock/01-xclock-1.0.9.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
./X/Xorg/Xorg-xinit/01-xinit-1.4.1.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&


#############################################################################
#
#   GTK-2.0 need
#
#############################################################################
# ./mld/alsa-tools/01-alsa-tools-1.2.2.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&

${log} `basename "$0"` " finished" blfs_all
