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
as_root chown root:root / #fixes problems with systemd installtion

./kde/01preKF5.sh &&
./kde/01preKDE.sh &&
./kde/01prePlasma.sh &&

source /etc/profile.d/xorg.sh && # Do not uncomment
source /etc/profile.d/extrapathtex.sh &&
source /etc/profile.d/qt5.sh &&
source /etc/profile.d/kf5.sh &&

source /etc/profile.d/openjdk.sh &&

${log} `basename "$0"` " started" blfs_all &&
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

./gnf-libs/wxWidgets/01-wxWidgets.sh &&
#./gnf-libs/vulkan/01-vulkan-1.2.162.1.sh &&



${log} `basename "$0"` " finished" blfs_all
