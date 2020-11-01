#!/bin/bash

for D in /sources/*; do
    if [ -d "${D}" ]; then
        #echo "${D}"
        if [[ "${D}" != *"/sources/Xorg"*  ]] && [[ "${D}" != *"/sources/kf5"*  ]] && [[ "${D}" != *"/sources/plasma"*  ]]; then
              echo "${D}"  # your processing here
              rm -rf ${D}
        fi
    fi
done




