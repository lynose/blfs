#!/bin/bash

export CURRENT_PATH=`pwd`


source ./help-functions.sh &&

export log=${CURRENT_PATH}/logger.sh
export MAKEFLAGS='-j 8' 


${log} `basename "$0"` " started" blfs_basic &&
${log} `basename "$0"` " ======================================" blfs_basic &&
${log} `basename "$0"`  "Started BLFS Basic Tools build" &&
${log} `basename "$0"` " ======================================" blfs_basic &&
./net/OpenSSH/01-openssh-8.4p1.sh &&
${log} `basename "$0"` " ======================================" blfs_basic &&
./gen-libs/libtasn1/01-libtasn1-4.16.0.sh &&
${log} `basename "$0"` " ======================================" blfs_basic &&
./sec/p11-kit/01-p11-kit-0.23.22.sh &&
${log} `basename "$0"` " ======================================" blfs_basic &&
./net/wget/01-wget-1.21.1.sh &&
${log} `basename "$0"` " ======================================" blfs_basic &&
./sec/make-ca/01-make-ca-1.7.sh &&
${log} `basename "$0"` " ======================================" blfs_basic &&
./sec/sudo/01-sudo-1.9.5p2.sh &&
${log} `basename "$0"` " ======================================" blfs_basic &&
${log} `basename "$0"` " finished" blfs_basic

