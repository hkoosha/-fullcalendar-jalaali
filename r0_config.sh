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
## Config parameters.


## unset to disable downloading kernel. file resides relative to base path.
RZ_KERNEL_URL="https://github.com/dhruvvyas90/qemu-rpi-kernel/raw/master"
RZ_KERNEL="kernel-qemu-4.1.7-jessie"

## base directory where everything will happen
RZ_PATH=$(pwd)

## the image we're fixing / loading. path is relative to base path
RZ_RASBPIAN_IMG="2015-11-21-raspbian-jessie.img"

## unset to disable fixing the image. path is relative to base path.
RZ_MPOINT="mnt"

## TODO: un-hardcode
## The filesystem (.img2) starts at sector 131072, which equals 512 * 131072 = 67108864 bytes. Use this as the offset
## the above line is from https://github.com/dhruvvyas90/qemu-rpi-kernel/wiki/Emulating-Jessie-image-with-4.1.7-kernel
## if the image is not the same used here, you should re-calculate
RZ_MOUNT_OFFSET=67108864

# QEMU-arm has (had?) bug for 256+ of ram
RZ_MEM=256
RZ_CPU="arm1176"
RZ_APPEND="root=/dev/sda2 rootfstype=ext4 rw"

