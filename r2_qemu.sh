#!/bin/bash

##  Copyright (C) 2016 koosha hosseiny
##
##  This program is free software: you can redistribute it and/or modify
##  it under the terms of the GNU General Public License as published by
##  the Free Software Foundation, either version 3 of the License, or
##  (at your option) any later version.
##
##  This program is distributed in the hope that it will be useful,
##  but WITHOUT ANY WARRANTY; without even the implied warranty of
##  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
##  GNU General Public License for more details.
##
##  You should have received a copy of the GNU General Public License
##  along with this program.  If not, see <http://www.gnu.org/licenses/>.

## About this script
## Runs a QEMU instance from a custom kernel and a fixed image

source r0_config.sh || exit 77
source r1_check.sh || exit 77
$RZ_KERNEL_F="$RZ_PATH/$RZ_KERNEL"
$RZ_IMG_F="$RZ_PATH/$RZ_RASBPIAN_IMG"

echo "running image"
echo "kernel: $RZ_KERNEL_F"
echo "cpu: $RZ_CPU"
echo "mem: $RZ_MEM"
echo "kernel append line: $RZ_APPEND"
echo "image: $RZ_IMG_F"

qemu-system-arm \
    -kernel $RZ_KERNEL_F \
    -cpu $RZ_CPU \
    -m $RZ_MEM \
    -M versatilepb \
    -no-reboot \
    -no-shutdown \
    -serial stdio \
    -append $RZ_APPEND \
    -hda $RZ_IMG_F

