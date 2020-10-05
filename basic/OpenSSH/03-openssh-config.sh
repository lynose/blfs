#!/bin/bash
${log} `basename "$0"` " started" blfs_basic &&
echo "PermitRootLogin no" >> /etc/ssh/sshd_config
${log} `basename "$0"` " finished" blfs_basic

