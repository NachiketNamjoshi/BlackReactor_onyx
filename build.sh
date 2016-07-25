#For Time Calculation
BUILD_START=$(date +"%s")

# Housekeeping
KERNEL_DIR=$PWD
KERN_IMG=$KERNEL_DIR/arch/arm/boot/zImage
OUT_DIR=$KERNEL_DIR/zipping/onyx

blue='\033[0;34m'
cyan='\033[0;36m'
yellow='\033[0;33m'
red='\033[0;31m'
nocol='\033[0m'


export ARCH=arm
export CROSS_COMPILE="/home/nachiket/android/onyx/kernel/toolchains/Linaro/arm-linux-androideabi-4.9/bin/arm-linux-androideabi-"
export KBUILD_BUILD_USER="nachiket"
export KBUILD_BUILD_HOST="reactor"


compile_kernel ()
{
echo -e "**********************************************************************************************"
echo "                    "
echo "                                    Compiling BlackReactor-Kernel                    "
echo "                    "
echo -e "**********************************************************************************************"
make onyx_defconfig
make -j64
if ! [ -a $KERN_IMG ];
then
echo -e "$red Kernel Compilation failed! Fix the errors! $nocol"
exit 1
fi
zipping
}

zipping() {
rm -rf $OUT_DIR/BlackReactor*.zip
rm -rf $OUT_DIR/Kernel*.zip
cp $KERN_IMG $OUT_DIR/zImage
cd $OUT_DIR
zip -r BlackReactor-onyx-$(date +"%Y%m%d")-$(date +"%H%M%S").zip *
OUT_PRODUCT = $OUT_DIR/BlackReactor-onyx*
}

compile_kernel
BUILD_END=$(date +"%s")
DIFF=$(($BUILD_END - $BUILD_START))
echo -e "$yellow Build completed in $(($DIFF / 60)) minute(s) and $(($DIFF % 60)) seconds.$nocol"
echo -e "$blue OUTPUT: $OUT_PRODUCT"