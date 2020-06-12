#!/bin/bash

${log} `basename "$0"` " started" blfs &&
${log} `basename "$0"` " ======================================" blfs &&
${log} `basename "$0"`  "Started BLFS build" &&

${log} `basename "$0"` " ======================================" blfs &&
./libs-common/libtasn1/01libtasn1.sh
${log} `basename "$0"` " ======================================" blfs &&



${log} `basename "$0"` " finished" blfs &&
