#!/system/bin/sh
chmod 644 /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
echo reactive > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
chmod 444 /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
chmod 644 /sys/devices/system/cpu/cpu1/cpufreq/scaling_governor
echo reactive > /sys/devices/system/cpu/cpu1/cpufreq/scaling_governor
chmod 444 /sys/devices/system/cpu/cpu1/cpufreq/scaling_governor
chmod 644 /sys/devices/system/cpu/cpu2/cpufreq/scaling_governor
echo reactive > /sys/devices/system/cpu/cpu2/cpufreq/scaling_governor
chmod 444 /sys/devices/system/cpu/cpu2/cpufreq/scaling_governor
chmod 644 /sys/devices/system/cpu/cpu3/cpufreq/scaling_governor
echo reactive > /sys/devices/system/cpu/cpu3/cpufreq/scaling_governor
chmod 444 /sys/devices/system/cpu/cpu3/cpufreq/scaling_governor
echo 512 > /proc/sys/kernel/random/read_wakeup_threshold
echo 512 > /proc/sys/kernel/random/write_wakeup_threshold
echo 1 > /sys/devices/system/cpu/cpu1/online
echo 1 > /sys/devices/system/cpu/cpu2/online
echo 0 > /sys/devices/system/cpu/cpu3/online
chmod 644 /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq
echo 1267200 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq
chmod 444 /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq
chmod 644 /sys/devices/system/cpu/cpu1/cpufreq/scaling_max_freq
echo 1267200 > /sys/devices/system/cpu/cpu1/cpufreq/scaling_max_freq
chmod 444 /sys/devices/system/cpu/cpu1/cpufreq/scaling_max_freq
chmod 644 /sys/devices/system/cpu/cpu2/cpufreq/scaling_max_freq
echo 1267200 > /sys/devices/system/cpu/cpu2/cpufreq/scaling_max_freq
chmod 444 /sys/devices/system/cpu/cpu2/cpufreq/scaling_max_freq
echo 1 > /sys/devices/system/cpu/cpu3/online
chmod 644 /sys/devices/system/cpu/cpu3/cpufreq/scaling_max_freq
echo 1267200 > /sys/devices/system/cpu/cpu3/cpufreq/scaling_max_freq
chmod 444 /sys/devices/system/cpu/cpu3/cpufreq/scaling_max_freq
echo 883200 > /sys/devices/system/cpu/cpufreq/reactive/freq_for_responsiveness_max
echo 729600 > /sys/devices/system/cpu/cpufreq/reactive/freq_for_responsiveness
echo 27500 > /sys/devices/system/cpu/cpufreq/reactive/sampling_rate
echo 740 740 740 745 765 775 785 805 815 845 855 880 925 985 > /sys/devices/system/cpu/cpu0/cpufreq/UV_mV_table
echo 1 > /sys/kernel/fast_charge/force_fast_charge
echo 4 > /sys/devices/fdb00000.qcom,kgsl-3d0/kgsl/kgsl-3d0/min_pwrlevel
echo 1024,2048,4096,8192,12288,16384 > /sys/module/lowmemorykiller/parameters/minfree
echo 1024 > /sys/block/mmcblk0/queue/read_ahead_kb
echo 2048 > /sys/block/mmcblk1/queue/read_ahead_kb
echo row > /sys/block/mmcblk0/queue/scheduler
echo row > /sys/block/mmcblk1/queue/scheduler
echo 600 > /proc/sys/vm/dirty_writeback_centisecs
echo 8192 > /proc/sys/vm/min_free_kbytes
echo 32768 > /proc/sys/vm/extra_free_kbytes
echo 512 > /proc/sys/kernel/random/read_wakeup_threshold
echo 652800 > /sys/module/cpu_boost/parameters/sync_threshold
echo 729600 > /sys/module/cpu_boost/parameters/input_boost_freq
echo 0 > /sys/block/mmcblk0/queue/iostats
echo 0 > /sys/block/mmcblk0/queue/add_random
echo 0 > /proc/sys/vm/swappiness
echo 600 > /proc/sys/vm/dirty_writeback_centisecs
echo 8192 > /proc/sys/vm/min_free_kbytes
echo 32768 > /proc/sys/vm/extra_free_kbytes
echo 512 > /proc/sys/kernel/random/read_wakeup_threshold
echo 8192 > /proc/sys/vm/min_free_kbytes
echo 32768 > /proc/sys/vm/extra_free_kbytes