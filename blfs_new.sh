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
/bin/bash -l ./sec/sudo/01-sudo-1.9.6p1.sh && #47
/bin/bash -l ./gen-libs/nspr/01-nspr-4.30.sh && #109
/bin/bash -l ./db/sqlite/01-sqlite-3.35.1.sh && #111
/bin/bash -l ./sec/sudo/02-sudo-1.9.6p1.sh && #221
/bin/bash -l ./fsndm/xfsprogs/01-xfsprogs-5.11.0.sh && #235
/bin/bash -l ./devel/cmake/01-cmake-3.19.7.sh && #321
/bin/bash -l ./gnf-libs/qpdf/01-qpdf-10.3.1.sh && #333
/bin/bash -l ./server/openldap/01-openldap-2.4.58.sh && #425
/bin/bash -l ./fsndm/gptfdisk/01-gptfdisk-1.0.7.sh && #465
/bin/bash -l ./sec/cryptsetup/01-cryptsetup-2.3.5.sh && #481
/bin/bash -l ./gen-libs/libxkbcommon/01-libxkbcommon-1.1.0.sh && #602
/bin/bash -l ./gnf-libs/harfbuzz/01-harfbuzz-2.8.0.sh && #634
/bin/bash -l ./gen-libs/libgusb/01-libgusb-0.3.6.sh && #646
/bin/bash -l ./gen-libs/libgudev/01-libgudev-236.sh && #656
/bin/bash -l ./X/pango/01-pango-1.48.3.sh && #686
/bin/bash -l ./X/gtk+/01-gtk+-3.24.27.sh && #690
/bin/bash -l ./xfce/exo/01-exo-4.16.1.sh && #694
/bin/bash -l ./devel/cmake/02-cmake-3.19.7.sh && #741
/bin/bash -l ./net/NetworkManager/01-NetworkManager-1.30.2.sh && #807
/bin/bash -l ./gnome/gnome-online-accounts/01-gnome-online-accounts-3.38.1.sh &&  #814
/bin/bash -l ./net/wireshark/01-wireshark-3.4.4.sh && #941












${log} `basename "$0"` " finished" blfs_all
