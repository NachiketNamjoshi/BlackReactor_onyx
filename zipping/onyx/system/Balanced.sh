#!/system/bin/sh
echo 740 740 740 745 765 775 785 805 815 845 855 880 925 985 > /sys/devices/system/cpu/cpu0/cpufreq/UV_mV_table
echo 5000 > /sys/module/adreno_idler/parameters//adreno_idler_idleworkload
echo 1024 > /sys/block/mmcblk0/queue/read_ahead_kb
echo 2048 > /sys/block/mmcblk1/queue/read_ahead_kb
echo row > /sys/block/mmcblk0/queue/scheduler
echo row > /sys/block/mmcblk1/queue/scheduler
echo 0 > /sys/block/mmcblk0/queue/iostats
echo 0 > /sys/block/mmcblk0/queue/add_random
echo 0 > /proc/sys/vm/swappiness
echo 600 > /proc/sys/vm/dirty_writeback_centisecs
echo 5000 > /proc/sys/vm/dirty_expire_centisecs
echo 8192 > /proc/sys/vm/min_free_kbytes
echo 32768 > /proc/sys/vm/extra_free_kbytes
echo 512 > /proc/sys/kernel/random/read_wakeup_threshold
chmod 644 /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq
echo 1958400 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq
chmod 444 /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq
chmod 644 /sys/devices/system/cpu/cpu1/cpufreq/scaling_max_freq
echo 1958400 > /sys/devices/system/cpu/cpu1/cpufreq/scaling_max_freq
chmod 444 /sys/devices/system/cpu/cpu1/cpufreq/scaling_max_freq
chmod 644 /sys/devices/system/cpu/cpu2/cpufreq/scaling_max_freq
echo 1958400 > /sys/devices/system/cpu/cpu2/cpufreq/scaling_max_freq
chmod 444 /sys/devices/system/cpu/cpu2/cpufreq/scaling_max_freq
chmod 644 /sys/devices/system/cpu/cpu3/cpufreq/scaling_max_freq
echo 1958400 > /sys/devices/system/cpu/cpu3/cpufreq/scaling_max_freq
chmod 444 /sys/devices/system/cpu/cpu3/cpufreq/scaling_max_freq
chmod 644 /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq
echo 300000 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq
chmod 444 /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq
chmod 644 /sys/devices/system/cpu/cpu1/cpufreq/scaling_min_freq
echo 300000 > /sys/devices/system/cpu/cpu1/cpufreq/scaling_min_freq
chmod 444 /sys/devices/system/cpu/cpu1/cpufreq/scaling_min_freq
chmod 644 /sys/devices/system/cpu/cpu2/cpufreq/scaling_min_freq
echo 300000 > /sys/devices/system/cpu/cpu2/cpufreq/scaling_min_freq
chmod 444 /sys/devices/system/cpu/cpu2/cpufreq/scaling_min_freq
chmod 644 /sys/devices/system/cpu/cpu3/cpufreq/scaling_min_freq
echo 300000 > /sys/devices/system/cpu/cpu3/cpufreq/scaling_min_freq
chmod 444 /sys/devices/system/cpu/cpu3/cpufreq/scaling_min_freq
chmod 644 /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
echo reactive > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
chmod 444 /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
echo 1 > /sys/devices/system/cpu/cpu1/online
chmod 644 /sys/devices/system/cpu/cpu1/cpufreq/scaling_governor
echo reactive > /sys/devices/system/cpu/cpu1/cpufreq/scaling_governor
chmod 444 /sys/devices/system/cpu/cpu1/cpufreq/scaling_governor
echo 1 > /sys/devices/system/cpu/cpu2/online
chmod 644 /sys/devices/system/cpu/cpu2/cpufreq/scaling_governor
echo reactive > /sys/devices/system/cpu/cpu2/cpufreq/scaling_governor
chmod 444 /sys/devices/system/cpu/cpu2/cpufreq/scaling_governor
echo 1 > /sys/devices/system/cpu/cpu3/online
chmod 644 /sys/devices/system/cpu/cpu3/cpufreq/scaling_governor
echo reactive > /sys/devices/system/cpu/cpu3/cpufreq/scaling_governor
chmod 444 /sys/devices/system/cpu/cpu3/cpufreq/scaling_governor
echo 25000 > /sys/devices/system/cpu/cpufreq/reactive/sampling_rate
echo 20 > /sys/module/cpu_boost/parameters/boost_ms
echo 40 > /sys/module/cpu_boost/parameters/input_boost_ms
echo 4 > /sys/devices/fdb00000.qcom,kgsl-3d0/kgsl/kgsl-3d0/min_pwrlevel
echo 1024,2048,4096,8192,12288,16384 > /sys/module/lowmemorykiller/parameters/minfree
echo msm-adreno-tz > /sys/devices/fdb00000.qcom,kgsl-3d0/kgsl/kgsl-3d0/devfreq/governor
echo 729600 > /sys/module/cpu_boost/parameters/sync_threshold
echo 1036800 > /sys/module/cpu_boost/parameters/input_boost_freq