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

echo -e "\nBased on work (kernel and tutorial) available on:"
echo -e "http://github.com/dhruvvyas90/qemu-rpi-kernel/wiki/Emulating-Jessie-image-with-4.1.7-kernel"
echo -e "By loolooyyyy, script available on:"
echo -e "http://github.com/loolooyyyy/rassbpery-qemu"

function rz_exit() {
  if [[ -z $1 ]]; then 
      echo -e ""
      exit 0
  else
      echo $1;
      echo -e ""
      exit 127;
  fi
}

function rz_usage() {
    echo -e ""
    echo -e "usage: $0 [arg]"
    echo -e ""
    echo -e "Arg:"
    echo -e "\tall (runs all steps below in proper order"
    echo -e "\tdl (downloads the proper kernel)"
    echo -e "\tfix (fixes the downloaded image. does NOT download the image)"
    echo -e "\trun (runs the qemu instace)"
    echo -e ""
    rz_exit $1
}

function rz_run() {
    if [[ $1 == "fix" ]]; then
        source r2_fix.sh || rz_exit "r2_fix.sh failed"
    elif [[ $1 == "run" ]]; then
        source r2_qemu.sh || rz_exit "r2_qemu.sh failed"
    elif [[ $1 == "dl" ]]; then
        source r2_kernel_dl.sh || rz_exit "r2_kernel_dl.sh failed"
    else
        rz_usage "unkown command: $1"
    fi
}


if [[ -z $1 ]]; then
    rz_usage
elif [[ "$1" == "all" ]]; then
    echo "running dl, fix, run in order"
    rz_run dl
    rz_run fix
    rz_run run
else
    rz_run $1
fi

