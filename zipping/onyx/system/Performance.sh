#!/system/bin/sh

chmod 644 /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq
echo 2265600 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq
chmod 444 /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq
chmod 644 /sys/devices/system/cpu/cpu1/cpufreq/scaling_max_freq
echo 2265600 > /sys/devices/system/cpu/cpu1/cpufreq/scaling_max_freq
chmod 444 /sys/devices/system/cpu/cpu1/cpufreq/scaling_max_freq
chmod 644 /sys/devices/system/cpu/cpu2/cpufreq/scaling_max_freq
echo 2265600 > /sys/devices/system/cpu/cpu2/cpufreq/scaling_max_freq
chmod 444 /sys/devices/system/cpu/cpu2/cpufreq/scaling_max_freq
chmod 644 /sys/devices/system/cpu/cpu3/cpufreq/scaling_max_freq
echo 2265600 > /sys/devices/system/cpu/cpu3/cpufreq/scaling_max_freq
chmod 444 /sys/devices/system/cpu/cpu3/cpufreq/scaling_max_freq
chmod 644 /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
echo elementalx > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
chmod 444 /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
echo 1 > /sys/devices/system/cpu/cpu1/online
chmod 644 /sys/devices/system/cpu/cpu1/cpufreq/scaling_governor
echo elementalx > /sys/devices/system/cpu/cpu1/cpufreq/scaling_governor
chmod 444 /sys/devices/system/cpu/cpu1/cpufreq/scaling_governor
echo 1 > /sys/devices/system/cpu/cpu2/online
chmod 644 /sys/devices/system/cpu/cpu2/cpufreq/scaling_governor
echo elementalx > /sys/devices/system/cpu/cpu2/cpufreq/scaling_governor
chmod 444 /sys/devices/system/cpu/cpu2/cpufreq/scaling_governor
echo 1 > /sys/devices/system/cpu/cpu3/online
chmod 644 /sys/devices/system/cpu/cpu3/cpufreq/scaling_governor
echo elementalx > /sys/devices/system/cpu/cpu3/cpufreq/scaling_governor
chmod 444 /sys/devices/system/cpu/cpu3/cpufreq/scaling_governor
echo 960000 > /sys/module/cpu_boost/parameters/sync_threshold
echo 1267200 > /sys/module/cpu_boost/parameters/input_boost_freq
echo 755 755 755 760 780 790 800 820 830 860 870 895 940 1000 > /sys/devices/system/cpu/cpu0/cpufreq/UV_mV_table
echo 1024,2048,4096,8192,12288,16384 > /sys/module/lowmemorykiller/parameters/minfree
echo msm-adreno-tz > /sys/devices/fdb00000.qcom,kgsl-3d0/kgsl/kgsl-3d0/devfreq/governor
echo 4000 > /sys/module/adreno_idler/parameters//adreno_idler_idleworkload
echo 578000000 > /sys/devices/fdb00000.qcom,kgsl-3d0/kgsl/kgsl-3d0/max_gpuclk
echo 4 > /sys/devices/fdb00000.qcom,kgsl-3d0/kgsl/kgsl-3d0/min_pwrlevel
echo row > /sys/block/mmcblk0/queue/scheduler
echo row > /sys/block/mmcblk1/queue/scheduler
echo 600 > /proc/sys/vm/dirty_writeback_centisecs
echo 5000 > /proc/sys/vm/dirty_expire_centisecs