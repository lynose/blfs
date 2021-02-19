#!/bin/bash
export CURRENT_PATH=`pwd`
unset LFS

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
as_root chown root:root / #fixes problems with systemd installtion

source /etc/profile.d/xorg.sh && # Do not uncomment
source /etc/profile.d/extrapathtex.sh &&
source /etc/profile.d/kf5.sh &&
source /etc/profile.d/qt5.sh &&
source /etc/profile.d/openjdk.sh &&

${log} `basename "$0"` " started" blfs_kde &&
${log} `basename "$0"` " ======================================" blfs_kde &&
${log} `basename "$0"`  "Started BLFS build" &&
${log} `basename "$0"` " ======================================" blfs_kde &&
${log} `basename "$0"` "                                       " blfs_kde &&
${log} `basename "$0"` "                                       " blfs_kde &&
#############################################################################
#
#   Packages without required and recommended dependencies
#
#############################################################################
#./kde/itinerary/01-itinerary.sh &&
#./X/packagekitqt5/01-packagekitqt5.sh &&
./kde/kcalc/01-kalc.sh &&
#./virt/libvirt/01-libvirt.sh &&
#./kde/krita/01-krita.sh


${log} `basename "$0"` " ======================================" blfs_kde &&
${log} `basename "$0"` " finished" blfs_kde
