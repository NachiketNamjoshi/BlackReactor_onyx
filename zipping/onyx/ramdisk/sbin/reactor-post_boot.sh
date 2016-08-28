#!/system/bin/sh

############################
# Custom Kernel Settings

# Define Basic Paths:

SD_PATH="/data/media/0"
REACTOR_DATA="$SD_PATH/BlackReactor"
REACTOR_LOGFILE="$REACTOR_DATA/reactor.log"
REACTOR_STARTCONFIG="/data/.black_reactor/startconfig"
REACTOR_STARTCONFIG_EARLY="/data/.black_reactor/startconfig_early"
REACTOR_STARTCONFIG_DONE="/data/.black_reactor/startconfig_done"
REACTOR_LOGFILE_SOUND="$REACTOR_DATA/reactor_sound.log"

# block devices
SYSTEM_DEVICE="/dev/block/platform/msm_sdcc.1/by-name/system"
CACHE_DEVICE="/dev/block/platform/msm_sdcc.1/by-name/cache"
DATA_DEVICE="/dev/block/platform/msm_sdcc.1/by-name/userdata"


# LOG Entry
if [ ! -d "$REACTOR_DATA" ] ; then
		/sbin/busybox mkdir $REACTOR_DATA
fi


	/sbin/busybox chmod 775 $SD_PATH
	/sbin/busybox chown 1023:1023 $SD_PATH

	/sbin/busybox chmod -R 775 $REACTOR_DATA
	/sbin/busybox chown -R 1023:1023 $REACTOR_DATA

# maintain log file history
	rm $REACTOR_LOGFILE.3
	mv $REACTOR_LOGFILE.2 $REACTOR_LOGFILE.3
	mv $REACTOR_LOGFILE.1 $REACTOR_LOGFILE.2
	mv $REACTOR_LOGFILE $REACTOR_LOGFILE.1

# Initialize the log file (chmod to make it readable also via /sdcard link)
	echo $(date) BlackReactor-Kernel initialization started > $REACTOR_LOGFILE
	/sbin/busybox chmod 666 $REACTOR_LOGFILE
	/sbin/busybox cat /proc/version >> $REACTOR_LOGFILE
	echo "=========================" >> $REACTOR_LOGFILE
	/sbin/busybox grep ro.build.version /system/build.prop >> $REACTOR_LOGFILE
echo "=========================" >> $REACTOR_LOGFILE


# # maintain sound log file history
# 	rm $REACTOR_LOGFILE_SOUND.3
# 	mv $REACTOR_LOGFILE_SOUND.2 $REACTOR_LOGFILE_SOUND.3
# 	mv $REACTOR_LOGFILE_SOUND.1 $REACTOR_LOGFILE_SOUND.2
# 	mv $REACTOR_LOGFILE_SOUND $REACTOR_LOGFILE_SOUND.1

# # Initialise the sound log file (chmod to make it readable via /sdcard link)
# echo $(date) BlackReactor-Kernel initialization started > $REACTOR_LOGFILE_SOUND
# /sbin/busybox chmod 666 $REACTOR_LOGFILE_SOUND
# echo -e "\n============================================\n" >> REACTOR_LOGFILE_SOUND
# echo -e "\n**** blackReactor_sound\n" >> REACTOR_LOGFILE_SOUND
# echo "\n============================================\n" >> REACTOR_LOGFILE_SOUND
# cd /sys/class/misc/blackReactor_sound
# /sbin/busybox find * -print -maxdepth 0 -type f -exec tail -v -n +1 {} + >> REACTOR_LOGFILE_SOUND
# echo "\n============================================\n" >> REACTOR_LOGFILE_SOUND


echo "\n=========================\n" >> $REACTOR_LOGFILE
echo "$(date) Tweaking interactive cpufreq gov" >> $REACTOR_LOGFILE
tweak_interactive
echo "\n=========================\n" >> $REACTOR_LOGFILE


# set busybox selinux labels
mount -o rw,remount rootfs /
	chcon u:object_r:toolbox_exec:s0 /sbin/busybox
mount -o ro,remount rootfs /


function tweak_interactive() {
/sbin/busybox chmod 644 /sys/devices/system/cpu/cpufreq/interactive/*
echo "20000" > /sys/devices/system/cpu/cpufreq/interactive/timer_rate
echo "40000" > /sys/devices/system/cpu/cpufreq/interactive/min_sample_time
echo "760000" > /sys/devices/system/cpu/cpufreq/interactive/midrange_freq
echo "1300000" > /sys/devices/system/cpu/cpufreq/interactive/max_normal_freq
echo "1900000" > /sys/devices/system/cpu/cpufreq/interactive/max_boost
echo "65" > /sys/devices/system/cpu/cpufreq/interactive/midrange_go_maxspeed_load
echo "85" > /sys/devices/system/cpu/cpufreq/interactive/go_maxspeed_load
/sbin/busybox chmod 444 /sys/devices/system/cpu/cpufreq/interactive/*
}
