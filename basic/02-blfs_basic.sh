#!/bin/bash

${log} `basename "$0"` " started" blfs_basic &&
${log} `basename "$0"` " ======================================" blfs_basic &&
${log} `basename "$0"`  "Started BLFS Basic Tools build" &&
${log} `basename "$0"` " ======================================" blfs_basic &&
./OpenSSH/openssh_basic-sh &&
${log} `basename "$0"` " ======================================" blfs_basic &&
./libtasn1/01-libtasn1-4.16.0.sh &&
${log} `basename "$0"` " ======================================" blfs_basic &&
./p11-kit/01-p11-kit-0.23.20.sh &&
${log} `basename "$0"` " ======================================" blfs_basic &&
./Wget/01-wget-1.20.3.sh
${log} `basename "$0"` " ======================================" blfs_basic &&
./make-ca/01-make-ca-1.7.sh &&
${log} `basename "$0"` " ======================================" blfs_basic &&

${log} `basename "$0"` " finished" blfs_basic

