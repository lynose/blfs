#!/bin/bash
export TEXARCH=$(uname -m | sed -e 's/i.86/i386/' -e 's/$/-linux/') &&

as_root cat >> /etc/profile.d/extrapaths.sh << EOF

# Begin texlive addition

pathappend /opt/texlive/2020/texmf-dist/doc/man  MANPATH
pathappend /opt/texlive/2020/texmf-dist/doc/info INFOPATH
pathappend /opt/texlive/2020/bin/$TEXARCH

# End texlive addition

EOF

unset TEXARCH
