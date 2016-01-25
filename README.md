# rassbpery-qemu

Run a Raspbian image on qemu. To run raspbian, some modifications are needed, the most important is the need for a custom kernel. Also qemu has some bugs emulating ARM cpus (the ram limit). This script takes care of downloading the custom kernel, modifying the image, and running the qemu instance.

based on https://github.com/dhruvvyas90/qemu-rpi-kernel. Also have a look at the [wiki](https://github.com/dhruvvyas90/qemu-rpi-kernel/wiki/Emulating-Jessie-image-with-4.1.7-kernel).

### Supported environments

Works **only** on posix compliant systems! 
MS-Windows is NOT supported and there is no plan to do so. Cygwin is not tested.

### Configurations

There is not much to configure. You may want to resize the image to have more space available for downlaoding extra stuff on your image. It is not supported by this image but is easily done. search and you'll find it.

All the configurable options are available in the `r0_config.sh` file.

### Usage

The image must be downloaded manually and put in the script directory. As of writing this readme the lastest image is `2015-11-21-raspbian-jessie.img` available at [https://www.raspberrypi.org/downloads/raspbian/](https://www.raspberrypi.org/downloads/raspbian/). Download the zip file and extract it. The kernel will be downloaded by the script.

```bash
bash$ ./r3_run.sh # prints usage
bash$ ./r3_run.sh dl # downloads the custom kernel
bash$ sudo ./r3_run.sh fix # fix the image file by mouting and modifying the files
bash$ ./r3_run.sh run # run the qemu instance
```

### To do
- don't donwload the kernel if it already is.
- download the image.
- check for the lastest image and kernel (do not hardcode in the config).
