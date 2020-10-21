#!/bin/bash

for D in /sources/*; do
    if [ -d "${D}" ]; then
        #echo "${D}"
        if [[ "${D}" != *"/sources/Xorg"*  ]]; then
              echo "${D}"  # your processing here
              rm -rf ${D}
        fi
    fi
done




