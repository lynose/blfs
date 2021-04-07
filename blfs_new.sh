#!/bin/bash
export CURRENT_PATH=`pwd`


source ./help-functions.sh &&

export log=${CURRENT_PATH}/logger.sh
export MAKEFLAGS='-j 8'
export NINJAJOBS=8
export ENABLE_TEST=false
export DANGER_TEST=false
#############################################################################
#
#   Global Xorg configuration
#
#############################################################################


${log} `basename "$0"` " started" blfs_new &&
${log} `basename "$0"` " ======================================" blfs_all &&
${log} `basename "$0"`  "Started BLFS build" &&
${log} `basename "$0"` " ======================================" blfs_all &&
${log} `basename "$0"` "                                       " blfs_all &&
${log} `basename "$0"` "                                       " blfs_all &&
#############################################################################
#
#   Staging
#
#############################################################################
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./devel/lua/01-lua-5.4.2.sh &&
# ./X/sddm/01-sddm.sh &&
# ./kde/sddm-kcm/01-sddm-kcm.sh &&
#./gnf-libs/wxWidgets/01-wxWidgets.sh &&
#./gnf-libs/vulkan/01-vulkan-1.2.162.1.sh &&
# 
# 
# #############################################################################
# #
# #   New in version
# #
# ############################################################################

# #############################################################################
# #
# #   Dependencies
# #
# ############################################################################
# 
# /bin/bash -l ./gen-libs/libssh2/01-libssh2-1.9.0.sh && #71
# /bin/bash -l ./devel/python2/01-python2-2.7.18.sh && #81
# /bin/bash -l ./db/sqlite/01-sqlite-3.35.4.sh && #111
# /bin/bash -l ./sec/nettle/01-nettle-3.7.2.sh && #117
# /bin/bash -l ./gen-libs/libgpg-error/01-libgpg-error-1.42.sh && #123
# /bin/bash -l ./devel/lua/01-lua-5.4.3.sh && #153
# /bin/bash -l ./net/bridge-utils/01-bridge-utils-1.7.1.sh && #235
# /bin/bash -l ./gen-libs/libassuan/01-libassuan-2.5.5.sh && #263
# /bin/bash -l ./sec/nss/01-nss-3.63.sh && #271
# /bin/bash -l ./fsndm/btrfs-progs/01-btrfs-progs-5.11.1.sh && #307
# /bin/bash -l ./net-libs/curl/01-curl-7.76.0.sh && #311
# /bin/bash -l ./devel/git/01-git-2.31.1.sh && #313
# /bin/bash -l ./devel/cmake/01-cmake-3.20.0.sh && #323
# /bin/bash -l ./net-libs/curl/02-curl-7.76.0.sh &&
# /bin/bash -l ./gnf-libs/jasper/01-jasper-2.0.28.sh && #337
# /bin/bash -l ./mld/flac/01-flac-1.3.3.sh && #367
# /bin/bash -l ./mld/libvpx/01-libvpx-1.10.0.sh && #397
# /bin/bash -l ./db/mariadb/01-mariadb-10.5.9.sh && #422
# /bin/bash -l ./gen-libs/glib/01-glib-2.68.0.sh && #444
# /bin/bash -l ./net-libs/glib-networking/01-glib-networking-2.68.0.sh && #454
# /bin/bash -l ./X/Xorg/Xorg-Libs/01-Xorg-libs.sh && #534
# /bin/bash -l ./devel/valgrind/01-valgrind-3.17.0.sh && #546
# /bin/bash -l ./gen-libs/dbus-glib/01-dbus-glib-0.112.sh && #558
# /bin/bash -l ./devel/vala/01-vala-0.52.0.sh &&
# /bin/bash -l ./X/cairo/01-cairo-1.17.4.sh && #610
# /bin/bash -l ./gen-libs/gobject-introspection/01-gobject-introspection-1.68.0.sh && #616
# /bin/bash -l ./X/gdk-pixbuf/01-gdk-pixbuf-2.42.4.sh && #644
# /bin/bash -l ./X/at-spi2-core/01-at-spi2-core-2.40.0.sh && #652
# /bin/bash -l ./devel/pygobject/01-pygobject-3.40.1.sh && #678
# /bin/bash -l ./X/pango/01-pango-1.48.4.sh && #690
# # /bin/bash -l ./X/gtk+/01-gtk+-3.24.28.sh && #6992
# /bin/bash -l ./xsoft/xscreensaver/01-xscreensaver-6.00.sh && #710
# /bin/bash -l ./devel/pygobject/01-pygobject-3.40.1.sh && #714
# /bin/bash -l ./print/ghostscript/01-ghostscript-9.54.0.sh && #728
# /bin/bash -l ./devel/cmake/02-cmake-3.20.0.sh && #744
# /bin/bash -l ./mld/pipewire/01-pipewire-0.3.24.sh && #782
# /bin/bash -l ./gen/graphviz/01-graphviz-2.47.0.sh && #748
# /bin/bash -l ./audio-utils/mpg123/01-mpg123-1.26.5.sh && #784
# /bin/bash -l ./kde/phonon-backend-vlc/01-phonon-backend-vlc-0.11.3.sh && #804
/bin/bash -l ./X/webkitgtk/01-webkitgtk-2.32.0.sh &&
# /bin/bash -l ./gen/gegl/01-gegl-0.4.30.sh && #828
/bin/bash -l ./gnf-libs/jasper/02-jasper-2.0.28.sh && #840
# /bin/bash -l ./gen-libs/libassuan/02-libassuan-2.5.5.sh && #844
# /bin/bash -l ./net/bind/01-bind-9.16.13.sh && #858
/bin/bash -l ./xsoft/gimp/01-gimp-2.10.24.sh &&
# /bin/bash -l ./print/cups-filter/01-cups-filters-1.28.8.sh && #874
# /bin/bash -l ./X/Xorg/Xorg-drivers/libinput/01-libinput-1.17.1.sh && #882
# /bin/bash -l ./X/xterm/01-xterm-367.sh && #906
# /bin/bash -l ./xsoft/thunderbird/01-thunderbird-78.9.0.sh && #953

${log} `basename "$0"` " finished" blfs_all
