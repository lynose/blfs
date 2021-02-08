#!/bin/bash
export CURRENT_PATH=`pwd`


source ./help-functions.sh &&

export log=${CURRENT_PATH}/logger.sh
export MAKEFLAGS='-j 2'
export NINJAJOBS=2
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
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./devel/lua/01-lua-5.4.2.sh &&
# 
# 
# 
# #############################################################################
# #
# #   Packages with required or recommended dependencies
# #
# ############################################################################
./db/postgresql/01-postgresql-13.1.sh && #410
${log} `basename "$0"` " ======================================" blfs_all &&
./gen-libs/libiodbc/01-libiodbc-3.52.12.sh && #660
${log} `basename "$0"` " ======================================" blfs_all &&
./sys/rasqal/01-rasqal-0.9.33.sh && #787
${log} `basename "$0"` " ======================================" blfs_all &&
./sys/redland/01-redland-1.0.17.sh && #788
${log} `basename "$0"` " ======================================" blfs_all &&
./kde/falkon/01-falkon-3.1.sh && #830
${log} `basename "$0"` " ======================================" blfs_all &&
./office/libreoffice/01-libreoffice-7.1.0.sh && #880
${log} `basename "$0"` " ======================================" blfs_all &&

${log} `basename "$0"` " finished" blfs_all
