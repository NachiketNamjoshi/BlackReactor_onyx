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
KERN_IMG=$KERNEL_DIR/arch/arm/boot/zImage-dtb
OUT_DIR=$KERNEL_DIR/zipping/onyx
REACTOR_VERSION="beta-3.8.1"

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
make clean && make mrproper
make onyx_defconfig
make -j32
if ! [ -a $KERN_IMG ];
then
echo -e "$red Kernel Compilation failed! Fix the errors! $nocol"
exit 1
fi
block_ads
zipping
}

zipping() {

# make new zip
cp $KERN_IMG $OUT_DIR/zImage
cd $OUT_DIR
zip -r BlackReactor-onyx-$REACTOR_VERSION-$(date +"%Y%m%d")-$(date +"%H%M%S").zip *

}

block_ads() {
HOSTS_FILE="$OUT_DIR/system/hosts"
HOST_FILE="$OUT_DIR/system/host"
rm -rf "$HOSTS_FILE"
wget -O $HOST_FILE"4" "http://pgl.yoyo.org/adservers/serverlist.php?hostformat=hosts&showintro=0&mimetype=plaintext"
wget -O $HOST_FILE"3" "http://adaway.org/hosts.txt"
cat $HOST_FILE"4" >> $HOST_FILE"3"; rm -rf $HOST_FILE"4"
wget -O $HOST_FILE"2" "http://hosts-file.net/ad_servers.txt"
cat $HOST_FILE"3" >> $HOST_FILE"2"; rm -rf $HOST_FILE"3"
wget -O $HOST_FILE"1" "http://winhelp2002.mvps.org/hosts.txt"
cat $HOST_FILE"2" >> $HOST_FILE"1"; rm -rf $HOST_FILE"2"
sed '/^#/ d' $HOST_FILE"1" > $HOST_FILE; 
rm -rf $HOST_FILE"1"
sort $HOST_FILE | uniq -u > $HOSTS_FILE; rm -rf $HOST_FILE
sed '/localhost/d' $HOSTS_FILE > $HOST_FILE; rm -rf $HOSTS_FILE
sed -i -e 's/0.0.0.0/127.0.0.1/g' $HOST_FILE; sed -i '1i #adblocker' $HOST_FILE
sed -i '2i 127.0.0.1 localhost' $HOST_FILE; sed -i '3i ::1 localhost' $HOST_FILE
awk '{$1=$1}1' OFS=" " $HOST_FILE > $HOSTS_FILE
sed -i -e '$a\' $HOSTS_FILE
rm -rf $HOST_FILE
}
compile_kernel
BUILD_END=$(date +"%s")
DIFF=$(($BUILD_END - $BUILD_START))
echo -e "$blue Build completed in $(($DIFF / 60)) minute(s) and $(($DIFF % 60)) seconds.$nocol"
echo -e "$red zImage size (bytes): $(stat -c%s $KERN_IMG) $nocol"
