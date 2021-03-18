#!/bin/bash
export CURRENT_PATH=`pwd`


source ./help-functions.sh &&

export log=${CURRENT_PATH}/logger.sh
export MAKEFLAGS='-j 7'
export NINJAJOBS=7
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

/bin/bash -l ./gnf-libs/qpdf/01-qpdf-10.3.1.sh && #333
/bin/bash -l ./fsndm/gptfdisk/01-gptfdisk-1.0.7.sh && #465
/bin/bash -l ./sec/cryptsetup/01-cryptsetup-2.3.5.sh && #481
/bin/bash -l ./gen-libs/libxkbcommon/01-libxkbcommon-1.1.0.sh && #602
/bin/bash -l ./X/pango/01-pango-1.48.3.sh && #686
/bin/bash -l ./net/wireshark/01-wireshark-3.4.4.sh && #941




${log} `basename "$0"` " finished" blfs_all
