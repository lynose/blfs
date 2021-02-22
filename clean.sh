#!/bin/bash
source ./help-functions.sh

for D in /sources/*; do
    if [ -d "${D}" ]; then
        #echo "${D}"
        if [[ "${D}" != *"/sources/Xorg"*  ]]      \
        && [[ "${D}" != *"/sources/kf5"  ]]       \
        && [[ "${D}" != *"/sources/plasma"  ]]    \
        && [[ "${D}" != *"/sources/games"  ]]     \
        && [[ "${D}" != *"/sources/kdeapps"  ]]   \
        && [[ "${D}" != *"/sources/git"  ]]       \
        && [[ "${D}" != *"/sources/kde"  ]]       \
        && [[ "${D}" != *"*.git"*  ]]; 
          then
              echo "${D}"  # your processing here
              as_root rm -rf ${D}
        fi
    fi
done

for D in /sources/kf5/*; do
    if [ -d "${D}" ]; 
      then
        echo "${D}"  # your processing here
        as_root rm -rf ${D}
    fi
done

for D in /sources/plasma/*; do
    if [ -d "${D}" ]; 
      then
        echo "${D}"  # your processing here
        as_root rm -rf ${D}
    fi
done

