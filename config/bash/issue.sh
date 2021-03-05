#!/bin/bash
${log} `basename "$0"` " started" config &&

echo '[Kilix \n \l' > /etc/issue &&

${log} `basename "$0"` " end" config
