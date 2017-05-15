#!/system/bin/sh

echo N > /sys/module/msm_thermal/parameters/enabled
echo 1 > /proc/touchpanel/sweep_wake_enable
echo 1 > /sys/module/msm_thermal/core_control/enabled
echo 0 > /sys/devices/virtual/misc/soundcontrol/volume_boost
echo 0 > /sys/block/mmcblk0/queue/add_random
echo 30000  > /sys/devices/system/cpu/cpufreq/impulse/above_hispeed_delay
echo powersave > /sys/devices/fdb00000.qcom,kgsl-3d0/kgsl/kgsl-3d0/devfreq/governor
echo 5 > /sys/devices/system/cpu/cpufreq/reactive/freq_step
echo 1 > /sys/devices/system/cpu/cpufreq/impulse/boost
setenforce 0
echo 2 > /sys/devices/system/cpu/cpufreq/zzmoove/profile_number
echo 27500  > /sys/devices/system/cpu/cpufreq/reactive/sampling_rate
echo 90 300000:10 422000:22 652000:35 729000:55 883000:75 960000:77 1036000:78 1190000:80 1267000:76 1497000:80 1574000:82 1728000:90 > /sys/devices/system/cpu/cpufreq/interactive/target_loads
echo 27000  > /sys/devices/system/cpu/cpufreq/interactive/min_sample_time
echo 18000  > /sys/devices/system/cpu/cpufreq/interactive/timer_rate
echo 80000  > /sys/devices/system/cpu/cpufreq/interactive/boostpulse_duration
echo 729600 > /sys/devices/system/cpu/cpufreq/interactive/hispeed_freq
echo 20 > /sys/module/cpu_boost/parameters/boost_ms
echo 40 > /sys/module/cpu_boost/parameters/input_boost_ms
echo 17500 883000:22500 1267000:27500 1728000:47500  > /sys/devices/system/cpu/cpufreq/interactive/above_hispeed_delay
echo 1 > /sys/kernel/fast_charge/force_fast_charge
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
echo 95  > /sys/devices/system/cpu/cpufreq/interactive/go_hispeed_load
echo 1 > /sys/devices/system/cpu/cpufreq/interactive/io_is_busy
echo 4 > /sys/block/mmcblk0/queue/iosched/fifo_batch
echo 4 > /sys/block/mmcblk1/queue/iosched/fifo_batch
echo 1 > /sys/block/mmcblk0/queue/rq_affinity
echo 1 > /proc/s1302/key_rep
echo 1 > /sys/module/snd_soc_wcd9320/parameters/spkr_drv_wrnd
echo 1 > /proc/touchpanel/double_tap_enable
echo N > /sys/module/wakeup/parameters/enable_si_ws
sysctl -w net.ipv4.tcp_congestion_control=yeah
echo N > /sys/module/workqueue/parameters/power_efficient
echo 1 > /proc/touchpanel/camera_enable
echo 20 > /sys/module/adreno_idler/parameters//adreno_idler_idlewait
echo 20 > /sys/module/adreno_idler/parameters//adreno_idler_downdifferential
echo 1 > /sys/devices/system/cpu/sched_mc_power_savings
echo 1036800 > /sys/devices/system/cpu/cpufreq/reactive/freq_for_responsiveness_max
echo 2 > /sys/kernel/msm_mpdecision/conf/max_cpus_online_susp
echo 20000 > /sys/kernel/msm_mpdecision/conf/startdelay
echo 125 > /sys/kernel/msm_mpdecision/conf/delay
echo 5 > /sys/kernel/msm_mpdecision/conf/nwns_threshold_1
echo 25 > /sys/kernel/msm_mpdecision/conf/nwns_threshold_0
echo 25 > /sys/kernel/msm_mpdecision/conf/nwns_threshold_2
echo 5 > /sys/kernel/msm_mpdecision/conf/nwns_threshold_3
echo 25 > /sys/kernel/msm_mpdecision/conf/nwns_threshold_4
echo 5 > /sys/kernel/msm_mpdecision/conf/nwns_threshold_5
echo 150 > /sys/kernel/msm_mpdecision/conf/twts_threshold_0
echo 200 > /sys/kernel/msm_mpdecision/conf/twts_threshold_1
echo 150 > /sys/kernel/msm_mpdecision/conf/twts_threshold_2
echo 200 > /sys/kernel/msm_mpdecision/conf/twts_threshold_3
echo 150 > /sys/kernel/msm_mpdecision/conf/twts_threshold_4
echo 200 > /sys/kernel/msm_mpdecision/conf/twts_threshold_5
echo 150 > /sys/kernel/msm_mpdecision/conf/twts_threshold_6
echo 200 > /sys/kernel/msm_mpdecision/conf/twts_threshold_7
echo 422400 > /sys/module/cpu_boost/parameters/sync_threshold
echo 1036800 > /sys/kernel/msm_mpdecision/conf/idle_freq
echo 4 > /sys/kernel/msm_mpdecision/conf/max_cpus
echo 500 > /sys/kernel/msm_mpdecision/conf/down_lock_duration
echo 20 > /sys/kernel/msm_mpdecision/conf/nwns_threshold_7
echo 35 > /sys/kernel/msm_mpdecision/conf/nwns_threshold_6
echo 729600 > /sys/devices/system/cpu/cpufreq/impulse/hispeed_freq
echo 0 > /sys/kernel/msm_mpdecision/conf/enabled
echo 0 > /proc/sys/vm/swappiness
echo 25 > /proc/sys/vm/dirty_ratio
echo 12 > /proc/sys/vm/dirty_background_ratio
echo 11 > /proc/sys/vm/vfs_cache_pressure
echo 4096 > /proc/sys/vm/min_free_kbytes
echo 8192 > /proc/sys/vm/extra_free_kbytes
echo 15 > /proc/sys/vm/overcommit_ratio
echo 500 > /proc/sys/vm/dirty_writeback_centisecs
echo 1024,2048,2560,4096,6144,8192 > /sys/module/lowmemorykiller/parameters/minfree
echo 256 > /proc/sys/kernel/random/read_wakeup_threshold
echo 512 > /proc/sys/kernel/random/write_wakeup_threshold
setprop service.adb.tcp.port -1
echo 652800 > /sys/module/cpu_boost/parameters/input_boost_freq
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
echo 1 > /sys/devices/system/cpu/cpu2/online
echo 1 > /sys/devices/system/cpu/cpu3/online
echo 96 > /sys/module/msm_hotplug/fast_lane_load
echo 35 > /sys/module/msm_hotplug/offline_load
echo 745 745 745 750 770 780 790 810 820 850 860 885 930 990 > /sys/devices/system/cpu/cpu0/cpufreq/UV_mV_table
echo 1 > /sys/module/msm_hotplug/cpus_boosted
echo 60 > /sys/module/msm_hotplug/update_rates
echo 1 > /sys/module/msm_hotplug/io_is_busy
echo 6000 > /sys/module/adreno_idler/parameters//adreno_idler_idleworkload
echo Y > /sys/module/state_notifier/parameters/enabled
echo zen > /sys/block/mmcblk0/queue/scheduler
echo 512 > /sys/block/mmcblk0/queue/read_ahead_kb
echo zen > /sys/block/mmcblk1/queue/scheduler
echo 512 > /sys/block/mmcblk1/queue/read_ahead_kb
echo 0 > /sys/devices/system/cpu/cpu1/online
echo 96 > /sys/devices/system/cpu/cpufreq/impulse/target_loads
chmod 644 /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
echo interactive > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
chmod 444 /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
echo 1 > /sys/devices/system/cpu/cpu1/online
chmod 644 /sys/devices/system/cpu/cpu1/cpufreq/scaling_governor
echo interactive > /sys/devices/system/cpu/cpu1/cpufreq/scaling_governor
chmod 444 /sys/devices/system/cpu/cpu1/cpufreq/scaling_governor
chmod 644 /sys/devices/system/cpu/cpu2/cpufreq/scaling_governor
echo interactive > /sys/devices/system/cpu/cpu2/cpufreq/scaling_governor
chmod 444 /sys/devices/system/cpu/cpu2/cpufreq/scaling_governor
chmod 644 /sys/devices/system/cpu/cpu3/cpufreq/scaling_governor
echo interactive > /sys/devices/system/cpu/cpu3/cpufreq/scaling_governor
chmod 444 /sys/devices/system/cpu/cpu3/cpufreq/scaling_governor
echo 5000 > /proc/sys/vm/dirty_expire_centisecs
start mpdecision
echo 4 > /sys/devices/fdb00000.qcom,kgsl-3d0/kgsl/kgsl-3d0/min_pwrlevel