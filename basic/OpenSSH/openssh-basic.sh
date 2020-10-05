#!/bin/bash
${log} `basename "$0"` " ======================================" blfs_basic &&
${log} `basename "$0"` " Started Openssh Basic build" &&
${log} `basename "$0"` " ======================================" blfs_basic &&
${log} `basename "$0"` " Prepare Openssh user"                           blfs_basic &&
./01-openssh-prepare.sh &&
${log} `basename "$0"` " ======================================" blfs_basic &&
${log} `basename "$0"` " Build Openssh"                          blfs_basic &&
./02-openssh-8.3p1.sh &&
${log} `basename "$0"` " Configure Openssh"                      blfs_basic &&
${log} `basename "$0"` " ======================================" blfs_basic &&
./03-openssh-config.sh &&
${log} `basename "$0"` " ======================================" blfs_basic &&
${log} `basename "$0"` " Finished Openssh Basic build" &&
${log} `basename "$0"` " ======================================" blfs_basic 
