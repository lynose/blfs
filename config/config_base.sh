#!/bin/bash

source ../help-functions.sh && 
export log=../logger.sh &&

${log} `basename "$0"` " started" config &&

./bash/profile.sh &&

./bash/bash_completion.sh &&

./bash/colors.sh &&

./bash/extra_path.sh &&

./bash/readline.sh &&

./bash/umask.sh &&

./bash/i18n.sh &&

./bash/userconfig.sh &&

#./bash/vimrc.sh &&

./bash/issue.sh &&

./lsb/config_lsb.sh &&

${log} `basename "$0"` " end" config 
