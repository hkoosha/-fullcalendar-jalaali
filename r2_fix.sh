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
## By default rasbpian image needs some modification and a custom kernel,
## as the default kernel does not support booting from a virtualized
## environment. 
## This script fixed the image, Custom kernel is handled elsewhere.


source r0_config.sh || exit 77
source r1_check.sh || exit 77
WORKING_DIR="$RZ_PATH/$RZ_MPOINT"
WORKING_IMG="$RZ_PATH/$RZ_RASBPIAN_IMG"

## mounting needs root
rz_check_root

echo -e "mount offset: $RZ_MOUNT_OFFSET -> this number is hardcoded for the image."
echo -e "If the image is changed, offset must be re-calculated. read more at the wiki"
echo -e "image: $WORKING_IMG"
echo -e "mount point: $WORKING_DIR"
echo -e ""
echo -e "!!! ATTENTION !!!"
echo -e "removing and re-creating $WORKING_DIR"
echo -e "you have 2 seconds to cancel..."
sleep 1
echo -e "you have 1 seconds to cancel..."
sleep 1

rm -rf "$WORKING_DIR"
mkdir "$WORKING_DIR"

echo "mounting image"
echo "mount -v
    -o offset=$RZ_MOUNT_OFFSET
    -t ext4
    $WORKING_IMG
    $WORKING_DIR
"

mount -v \
    -o offset=$RZ_MOUNT_OFFSET \
    -t ext4 \
    "$WORKING_IMG" \
    "$WORKING_DIR"  || rz_exit "could not mount image"

[[ -f "$WORKING_DIR/etc/ld.so.preload" ]] || rz_exit "ld.so.preload file not found, did the mount go alright?"
[[ -f "$WORKING_DIR/etc/fstab" ]] || rz_exit "fstab file not found, did the mount go alright?"

echo "fixing ld.so.preload and fstab files"
sed -e '/.*libarmmem.so.*/ s/^#*/#/' -i "$WORKING_DIR/etc/ld.so.preload" || rz_exit "could not fix ld.so.preload file"
sed -e '/.*\/dev\/mmcblk.*/ s/^#*/#/' -i "$WORKING_DIR/etc/fstab" || rz_exit "could not fix fstab file"

echo "done fixing, un-mounting the image"
echo -e "you have 1 seconds to cancel unmount if image needs furthur investigation"
sleep 1
umount "$WORKING_DIR" || rz_exit "could not unmount image"

