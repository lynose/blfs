#!/bin/bash

${log} `basename "$0"` " started" blfs &&
${log} `basename "$0"` " ======================================" blfs &&
${log} `basename "$0"`  "Started BLFS build" &&

${log} `basename "$0"` " ======================================" blfs &&
./libs-common/libtasn1/01libtasn1.sh &&
${log} `basename "$0"` " ======================================" blfs &&

${log} `basename "$0"` " ======================================" blfs &&
${log} `basename "$0"`  "Started Firefox section build" &&


${log} `basename "$0"` " ======================================" blfs &&
./devtools/autoconf-old/01-autoconf-2.16-old.sh &&

${log} `basename "$0"` " ======================================" blfs &&
./devtools/rustc/01-rustc-1.42.0.sh &&

${log} `basename "$0"` " ======================================" blfs &&
./devtools/cbindgen/01-cbindgen-0.14.2.sh &&


${log} `basename "$0"` " finished" blfs &&
