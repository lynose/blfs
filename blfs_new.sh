#!/bin/bash
export CURRENT_PATH=`pwd`


source ./help-functions.sh &&

export log=${CURRENT_PATH}/logger.sh
export MAKEFLAGS='-j3'
export NINJAJOBS=3
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
# #

if [ -f /etc/profile.d/rustc.sh ]
  then
    source /etc/profile.d/rustc.sh
fi

source /etc/profile.d/xorg.sh && # Do not uncomment
source /etc/profile.d/extrapathtex.sh &&
source /etc/profile.d/extrapaths.sh &&
source /etc/profile.d/kf5.sh &&
source /etc/profile.d/openjdk.sh &&

/bin/bash -l ./gen-libs/libuv/01-libuv-v1.41.1.sh && #67
/bin/bash -l ./gen-libs/nspr/01-nspr-4.32.sh && #111
/bin/bash -l ./fsndm/mdadm/01-mdadm-4.1.sh && #141
/bin/bash -l ./sys/hdparm/01-hdparm-9.62.sh && #209
/bin/bash -l ./fsndm/ntfs-3g/01-ntfs-3g-2017.3.23.sh && #211
/bin/bash -l ./sec/nss/01-nss-3.68.sh && #273
/bin/bash -l ./gen-libs/libbytesize/01-libbytesize-2.6.sh && #303
/bin/bash -l ./devel/ruby/01-ruby-3.0.2.sh && #379
/bin/bash -l ./gen-libs/libusb/01-libusb-1.0.24.sh && #401
/bin/bash -l ./mld/taglib/01-taglib-1.12.sh && #411
/bin/bash -l ./devel/llvm/01-llvm.sh && #413
/bin/bash -l ./db/mariadb/01-mariadb-10.6.3.sh && #422
/bin/bash -l ./gen-libs/JS/01-JS-78.12.0.sh && #466
/bin/bash -l ./gen-libs/nodejs/01-nodejs-v14.17.3.sh && #468
/bin/bash -l ./fsndm/gptfdisk/01-gptfdisk-1.0.8.sh && #470
/bin/bash -l ./sys/systemd/01-systemd-249.sh && #482
/bin/bash -l ./sec/gnupg/01-gnupg-2.2.29.sh && #488
/bin/bash -l ./gnf-libs/harfbuzz/01-harfbuzz-2.8.2.sh && #518
/bin/bash -l ./devel/python3/01-python-3.9.6.sh && #542
/bin/bash -l ./X/mesa/01-mesa-21.1.4.sh && #584
/bin/bash -l ./sys/bluez/01-bluez-5.60.sh && #636
/bin/bash -l ./gnf-libs/harfbuzz/01-harfbuzz-2.8.2.sh && #642
/bin/bash -l ./X/at-spi2-core/01-at-spi2-core-2.40.3.sh && #658
/bin/bash -l ./X/pango/01-pango-1.48.7.sh && #696
/bin/bash -l ./X/gtk+/01-gtk+-3.24.30.sh && #698
/bin/bash -l ./sec/gnupg/01-gnupg-2.2.29.sh && #780
/bin/bash -l ./mld/pipewire/01-pipewire-0.3.31.sh && #790
/bin/bash -l ./audio-utils/mpg123/01-mpg123-1.28.1.sh && #792
/bin/bash -l ./X/webkitgtk/01-webkitgtk-2.32.2.sh && #814
/bin/bash -l ./net/NetworkManager/01-NetworkManager-1.32.2.sh && #818
/bin/bash -l ./xsoft/firefox/01-firefox-78.12.0.sh && #820
/bin/bash -l ./gnf-libs/babl/01-babl-0.1.88.sh && #834
/bin/bash -l ./gnf-libs/poppler/01-poppler-21.07.0.sh && #842
/bin/bash -l ./X/Xorg/Xorg-server/01-xorg-server-1.20.12.sh && #886
/bin/bash -l ./devel/php/01-php-8.0.8.sh && #920
#############################################################################
#
#   Git section
#
############################################################################
# 
# ${log} `basename "$0"` " ======================================" blfs_all &&
# /bin/bash -l ./devel/clazy/01-clazy.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# /bin/bash -l ./devel/cppcheck/01-cppcheck.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# /bin/bash -l ./kde/okteta/01-okteta.sh &&



${log} `basename "$0"` " finished" blfs_all
