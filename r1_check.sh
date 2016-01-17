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
## Checks and sanitizes the configuration and environment.


function rz_exit() {
  if [[ -z $1 ]]; then 
      exit 0
  else
      echo $1;
      exit 127;
  fi
}

function rz_check_root() {
    if [[ "$EUID" -ne 0 ]]; then 
        echo "please run as root"
        exit 77
    fi
}

if [[ -z $RZ_PATH ]]; then
    rz_exit "base path not defined in \$RZ_PATH"
#else
    # echo "base path: $RZ_PATH"
fi

if [[ -z $RZ_KERNEL ]]; then
    rz_exit "kernel not defined in \$RZ_KERNEL"
#else
    # echo "kernel: $RZ_KERNEL"
fi

if [[ -z $RZ_RASBPIAN_IMG ]]; then
    rz_exit "img not defined in \$RZ_RASBPIAN_IMG"
#else
    # echo "image: $RZ_RASBPIAN_IMG"
fi

if [[ -z $RZ_KERNEL_URL ]]; then
    echo "downloading kernel not supported. downlad it manually"
#else
    # echo "downloading kernel from $RZ_KERNEL_URL"
fi

if [[ -z $RZ_MPOINT ]]; then
    echo "tweaking image not supported. fix it manually"
else
    [[ -z $RZ_MOUNT_OFFSET ]] && rz_exit "mount offset not set"
    which mount 2>/dev/null || rz_exit '`mount` not found!'
    # echo "mounting the image to fix it in: $RZ_MPOINT"
fi

