#!/bin/bash
export CURRENT_PATH=`pwd`


source ./help-functions.sh &&

export log=${CURRENT_PATH}/logger.sh
export MAKEFLAGS='-j7'
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
# #

#./kde/01preKF5.sh &&


if [ -f /etc/profile.d/rustc.sh ]
  then
    source /etc/profile.d/rustc.sh
fi

source /etc/profile.d/xorg.sh && # Do not uncomment
source /etc/profile.d/extrapathtex.sh &&
source /etc/profile.d/extrapaths.sh &&
source /etc/profile.d/kf5.sh &&
source /etc/profile.d/openjdk.sh &&

#/bin/bash -l ./fsndm/btrfs-progs/01-btrfs-progs-5.12.1.sh && #307
#/bin/bash -l ./sys/pciutils/01-pciutils-3.7.0.sh && #309
#/bin/bash -l ./server/openldap/01-openldap-2.5.5.sh && #424
#/bin/bash -l ./net-libs/curl/02-curl-7.77.0.sh && #426
#/bin/bash -l ./sec/polkit/01-polkit-0.119.sh && #478
#/bin/bash -l ./xfce/exo/01-exo-4.16.2.sh && #696
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
