#!/bin/bash

as_root()
{
  if   [ $EUID = 0 ];        then $*
  elif [ -x /usr/bin/sudo ]; then sudo $*
  else                            su -c \\"$*\\"
  fi
}

export -f as_root

as_root_userenv()
{
  if   [ $EUID = 0 ];        then $*
  elif [ -x /usr/bin/sudo ]; then sudo -E $*
  else                            su -c \\"$*\\"
  fi
}

export -f as_root_userenv



as_root_mkdir ()
{
  if [ -d $1 ];
    then return
  fi
  
  if   [ $EUID = 0 ];        then mkdir $1
  elif [ -x /usr/bin/sudo ]; then sudo mkdir $1
  else                            su -c \\"mkdir $1\\"
  fi
}
export -f as_root_mkdir

as_root_useradd()
{ 
    if id "${@: -1}" &>/dev/null; then
        echo 'user found'
    else
        if   [ $EUID = 0 ];        then $*
        elif [ -x /usr/bin/sudo ]; then echo "sudo $@"; sudo $@
        else                            su -c \\"$*\\"
        fi
    fi
}

export -f as_root_useradd

as_root_groupadd()
{ 
    echo $*

    if [ $(getent group ${@: -1}) ]; then
        echo 'group found'
    else
        if   [ $EUID = 0 ];        then $*
        elif [ -x /usr/bin/sudo ]; then echo "sudo $*"; sudo $*
        else                            su -c \\"$*\\"
        fi
    fi
}
export -f as_root_groupadd

check_and_download ()
{
  declare url=$1
  echo $url
  filename=`basename ${url}`
  echo ${filename}
  declare dirname=$2
  echo ${dirname}
  
  if [ ! -f ${dirname}/${filename} ];
    then 
      wget ${url} --no-check-certificate --continue --directory-prefix=${dirname}
  fi
}

export -f check_and_download

log()
{
    INFO=$2
    SCRIPTNAME=$1
    STAGE=$3
    LOGPATH=""
    LOGFILE=""

    if [ -d $LFS ]
    then
        LOGPATH=${LFS}
    fi

    if [ -d $LFS/log ]
    then
        LOGPATH="${LOGPATH}/log"
    else
        LOGPATH="/log"
    fi

    if [ -n ${STAGE} ]
    then
        LOGFILE="${STAGE}.log"
    else
        LOGFILE="default.log"
    fi

    CUR_TIME=$(date +%D" "%r)

    echo "${CUR_TIME} : ${SCRIPTNAME} ${INFO}" >> ${LOGPATH}/${LOGFILE}
}
export -f log

gitget ()
{
  PWD=pwd
  url=$1
  pack=`basename ${url}`
  packname=${pack:0: -4}
  dirname=$2
  repo=${dirname}/git
  gitpack=${repo}/${packname}
  if [ $3 ]; 
    then
        version=$3
  fi

  if [ ! -d ${repo}/${packname} ];
    then
      cd ${repo} &&
      git clone ${url} &&
      cd ${packname}
    else
      cd ${repo}/${packname} &&
      git pull
  fi
  
  if  [ $version ]; 
    then
      echo $version
      git checkout $version
  fi
  
  cd $PWD
}

export -f gitget
