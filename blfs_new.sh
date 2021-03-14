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
/bin/bash -l ./gen-libs/iso-codes/01-iso-codes-4.6.0.sh && #121
/bin/bash -l ./devel/git/01-git-2.30.2.sh && #311
/bin/bash -l ./sec/gnutls/01-gnutls-3.7.1.sh && #381
/bin/bash -l ./gnome/libgdata/01-libgdata-0.18.1.sh && #814
/bin/bash -l ./devel/php/01-php-8.0.3.sh && #906
/bin/bash -l ./xsoft/thunderbird/01-thunderbird-78.8.1.sh && #957
/bin/bash -l ./office/libreoffice/01-libreoffice-7.1.1.2.sh && #959
#./gnf-libs/wxWidgets/01-wxWidgets.sh &&
#./gnf-libs/vulkan/01-vulkan-1.2.162.1.sh &&



${log} `basename "$0"` " finished" blfs_all
