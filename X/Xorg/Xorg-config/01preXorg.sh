#!/bin/bash

${log} `basename "$0"` " started" xorg &&

cat > /etc/X11/xorg.conf.d/xkb-defaults.conf << "EOF"
Section "InputClass"
    Identifier "XKB Defaults"
    MatchIsKeyboard "yes"
    Option "XkbLayout" "de"
#    Option "XkbOptions" "terminate:ctrl_alt_bksp"
EndSection
EOF

cat > /etc/X11/xorg.conf.d/videocard-0.conf << "EOF"
Section "Device"
    Identifier  "Videocard0"
    Driver      "amdgpu"
    VendorName  "Videocard vendor"
    BoardName   "AMD Radeon 480"
#    Option      "NoAccel" "true"
EndSection
EOF

cat > /etc/X11/xorg.conf.d/server-layout.conf << "EOF"
Section "ServerLayout"
    Identifier     "DefaultLayout"
    Screen      0  "Screen0" 0 0
#    Screen      1  "Screen1" LeftOf "Screen0"
#    Option         "Xinerama"
EndSection
EOF

${log} `basename "$0"` " finished" xorg
