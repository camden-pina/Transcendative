#!/bin/sh
gdisk build/os-x86_64-bios.iso << EOF
o
y
n
1
2048
93716
ef00
w
y
EOF
