#!/bin/bash

##################################################
##################################################
# 												 #
# 	  Copyright (c) 2016, Nachiket.Namjoshi		 #
# 			 All rights reserved.				 #
# 												 #
# 	BlackReactor Kernel Build Script beta - v0.1 #
# 												 #
##################################################
##################################################

#For Time Calculation
BUILD_START=$(date +"%s")

# Housekeeping
blue='\033[0;34m'
cyan='\033[0;36m'
green='\033[1;32m'
red='\033[0;31m'
nocol='\033[0m'

# 
# Configure following according to your system
# 

# Directories
KERNEL_DIR=$PWD
KERN_IMG=$KERNEL_DIR/arch/arm/boot/zImage
OUT_DIR=$KERNEL_DIR/zipping/onyx
REACTOR_VERSION="beta-1.2"
KERN_DTB=$KERNEL_DIR/arch/arm/boot/dt.img

# Device Spceifics
export ARCH=arm
export CROSS_COMPILE="/home/nachiket/android/onyx/kernel/toolchains/Linaro/arm-linux-androideabi-4.9/bin/arm-linux-androideabi-"
export KBUILD_BUILD_USER="nachiket"
export KBUILD_BUILD_HOST="reactor"


########################
## Start Build Script ##
########################

# Remove Last builds
rm -rf $OUT_DIR/*.zip
rm -rf $OUT_DIR/zImage
rm -rf $OUT_DIR/dtb.img

compile_kernel ()
{
echo -e "$green ********************************************************************************************** $nocol"
echo "                    "
echo "                                   Compiling BlackReactor-Kernel                    "
echo "                    "
echo -e "$green ********************************************************************************************** $nocol"
make onyx_defconfig
make -j64 V=2
if ! [ -a $KERN_IMG ];
then
echo -e "$red Kernel Compilation failed! Fix the errors! $nocol"
exit 1
fi
build_dtb
zipping
}

build_dtb() {
	
	$KERNEL_DIR/tools/dtbtool -o $KERN_DTB -s 2048 -p $KERNEL_DIR/scripts/dtc/ $KERNEL_DIR/arch/arm/boot/
}


zipping() {

# make new zip
cp $KERN_IMG $OUT_DIR/zImage
cp $KERN_DTB $OUT_DIR/dtb.img
cd $OUT_DIR
zip -r BlackReactor-onyx-$REACTOR_VERSION-$(date +"%Y%m%d")-$(date +"%H%M%S").zip *

}

compile_kernel
BUILD_END=$(date +"%s")
DIFF=$(($BUILD_END - $BUILD_START))
echo -e "$blue Build completed in $(($DIFF / 60)) minute(s) and $(($DIFF % 60)) seconds.$nocol"
echo -e "$red zImage size (bytes): $(stat -c%s $KERN_IMG) $nocol"
