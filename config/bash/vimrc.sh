#/bin/bash
${log} `basename "$0"` " started" config &&
" Begin .vimrc

set columns=80
set wrapmargin=8
set ruler

" End .vimrc
${log} `basename "$0"` " end" config
