#!/bin/bash

as_root()
{
  if   [ $EUID = 0 ];        then $*
  elif [ -x /usr/bin/sudo ]; then sudo $*
  else                            su -c \\"$*\\"
  fi
}

export -f as_root

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
      wget ${url} --continue --directory-prefix=${dirname}
  fi
}

export -f check_and_download
