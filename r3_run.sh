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

echo "based on kernel and tutorial on https://github.com/dhruvvyas90/qemu-rpi-kernel/wiki/Emulating-Jessie-image-with-4.1.7-kernel"

function rz_exit() {
  if [[ -z $1 ]]; then 
      exit 0
  else
      echo $1;
      exit 127;
  fi
}


function rz_run() {

    if [[ $1 -eq "fix" ]]; then
        source source r2_fix.sh || exit 7

    elif [[ $1 -eq "run" ]]; then
        source source r2_fix.sh || exit 7;

    elif [[ $1 -eq "dl" ]]; then
        source r2_kernel_dl.sh || exit 7;
    else
        echo "unknown command: $1"
        exit 33
    fi

}

if [[ -z $1 ]]; then
    echo "usage: $0 [arg]"
    echo "Arg:"
    echo "\tall (runs all steps below in proper order"
    echo "\tdl (downloads the proper kernel)"
    echo "\tfix (fixes the downloaded image. does NOT download the image)"
    echo "\trun (runs the qemu instace)"
fi

if [[ $1 -eq "all" ]]; then
    rz_run dl
    rz_run fix
    rz_run run
else
    rz_run $1
fi

