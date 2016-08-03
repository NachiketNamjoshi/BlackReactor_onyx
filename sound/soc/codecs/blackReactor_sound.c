/*
 * Author: andip71, 21.09.2014
 * 
 * Version 1.0.0
 *
 * This software is licensed under the terms of the GNU General Public
 * License version 2, as published by the Free Software Foundation, and
 * may be copied, distributed, and modified under those terms.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 */

/*
 * Change log:
 * 
 * 1.0.0 (21.09.2014)
 *   - Initial version for OnePlus
 * 
 */

#include <linux/mfd/wcd9xxx/core.h>
#include <linux/mfd/wcd9xxx/wcd9xxx_registers.h>
#include <linux/mfd/wcd9xxx/wcd9320_registers.h>
#include <linux/mfd/wcd9xxx/pdata.h>
#include "wcd9320.h"
#include "wcd9xxx-resmgr.h"
#include "wcd9xxx-common.h"

#include "blackReactor_sound.h"


/*****************************************/
// Variables
/*****************************************/

// pointer to codec structure
static struct snd_soc_codec *codec;

// internal blackReactor sound variables
static int blackReactor_sound;	// blackReactor sound master switch
static int debug;			// debug switch

static int headphone_volume_l;
static int headphone_volume_r;
//static int speaker_volume_l;
//static int speaker_volume_r;
//static int mic_level;


/*****************************************/
// Black-Reactor sound hook functions for
// original wcd9320 alsa driver
/*****************************************/

void blackReactor_sound_hook_taiko_codec_probe(struct snd_soc_codec *codec_pointer)
{
	// store a copy of the pointer to the codec, we need
	// that for internal calls to the audio hub
	codec = codec_pointer;

	// Print debug info
	printk("Black-Reactor-sound: codec pointer received\n");
}


unsigned int blackReactor_sound_hook_taiko_write(unsigned int reg, unsigned int value)
{
	// if blackReactor sound is switched off, hook should not have any effect
	if (!blackReactor_sound)
		return value;

	switch (reg)
	{
		case TAIKO_A_CDC_RX1_VOL_CTL_B2_CTL: // headphone L
		{
			value = headphone_volume_l;
			break;
		}

		case TAIKO_A_CDC_RX2_VOL_CTL_B2_CTL: // headphone R
		{
			value = headphone_volume_l;
			break;
		}

//		case TAIKO_A_CDC_RX3_VOL_CTL_B2_CTL: // speaker
//		{
//			value = speaker_volume_l;
//			break;
//		}

//		case TAIKO_A_CDC_RX7_VOL_CTL_B2_CTL: // speaker
//		{
//			value = speaker_volume_r;
//			break;
//		}

//		case TAIKO_A_CDC_TX7_VOL_CTL_GAIN: // mic level general
//		{
//			value = mic_level;
//			break;
//		}
		
		default:
			break;
	}
	
	return value;
}


/*****************************************/
// internal helper functions
/*****************************************/

static void reset_blackReactor_sound(void)
{
	// set all blackReactor sound config settings to defaults
	headphone_volume_l = HEADPHONE_DEFAULT;
	headphone_volume_r = HEADPHONE_DEFAULT;
//	speaker_volume_l = SPEAKER_DEFAULT;
//	speaker_volume_r = SPEAKER_DEFAULT;
//	mic_level = MICLEVEL_DEFAULT;

	if (debug)
		printk("Black-Reactor-sound: blackReactor sound reset done\n");
}


static void reset_audio_hub(void)
{
	// reset all audio hub registers back to defaults
	taiko_write_no_hook(codec, TAIKO_A_CDC_RX1_VOL_CTL_B2_CTL, HEADPHONE_DEFAULT + HEADPHONE_REG_OFFSET);
	taiko_write_no_hook(codec, TAIKO_A_CDC_RX2_VOL_CTL_B2_CTL, HEADPHONE_DEFAULT + HEADPHONE_REG_OFFSET);

//	taiko_write_no_hook(codec, TAIKO_A_CDC_RX3_VOL_CTL_B2_CTL, SPEAKER_DEFAULT + SPEAKER_REG_OFFSET);
//	taiko_write_no_hook(codec, TAIKO_A_CDC_RX7_VOL_CTL_B2_CTL, SPEAKER_DEFAULT + SPEAKER_REG_OFFSET);

//	taiko_write_no_hook(codec, TAIKO_A_CDC_TX7_VOL_CTL_GAIN, MICLEVEL_DEFAULT + MICLEVEL_REG_OFFSET);

	if (debug)
		printk("Black-Reactor-sound: wcd9320 audio hub reset done\n");
}


/*****************************************/
// sysfs interface functions
/*****************************************/

// Black-Reactor sound master switch

static ssize_t blackReactor_sound_show(struct device *dev, struct device_attribute *attr, char *buf)
{
	// print current value
	return sprintf(buf, "Black-Reactor sound status: %d\n", blackReactor_sound);
}


static ssize_t blackReactor_sound_store(struct device *dev, struct device_attribute *attr,
					const char *buf, size_t count)
{
	unsigned int ret = -EINVAL;
	int val;

	// read values from input buffer
	ret = sscanf(buf, "%d", &val);

	if (ret != 1)
		return -EINVAL;
		
	// store if valid data
	if (((val == 0) || (val == 1)))
	{
		// set new status
		blackReactor_sound = val;

		// re-initialize settings and audio hub (in any case for both on and off !)
		reset_blackReactor_sound();
		reset_audio_hub();

		// print debug info
		if (debug)
			printk("Black-Reactor-sound: status %d\n", blackReactor_sound);
	}

	return count;
}


// Headphone volume

static ssize_t headphone_volume_show(struct device *dev, struct device_attribute *attr, char *buf)
{
	// print current values
	return sprintf(buf, "Headphone volume:\nLeft: %d\nRight: %d\n", 
		headphone_volume_l, headphone_volume_r);
}


static ssize_t headphone_volume_store(struct device *dev, struct device_attribute *attr,
					const char *buf, size_t count)
{
	unsigned int ret = -EINVAL;
	int val_l;
	int val_r;

	// Terminate if blackReactor sound is not enabled
	if (!blackReactor_sound)
		return count;

	// read values from input buffer
	ret = sscanf(buf, "%d %d", &val_l, &val_r);

	if (ret != 2)
		return -EINVAL;
		
	// check whether values are within the valid ranges and adjust accordingly
	if (val_l > HEADPHONE_MAX)
		val_l = HEADPHONE_MAX;

	if (val_l < HEADPHONE_MIN)
		val_l = HEADPHONE_MIN;

	if (val_r > HEADPHONE_MAX)
		val_r = HEADPHONE_MAX;

	if (val_r < HEADPHONE_MIN)
		val_r = HEADPHONE_MIN;

	// store new values
	headphone_volume_l = val_l;
	headphone_volume_r = val_r;

	// set new values
	taiko_write_no_hook(codec, TAIKO_A_CDC_RX1_VOL_CTL_B2_CTL, 
		headphone_volume_l + HEADPHONE_REG_OFFSET);
	taiko_write_no_hook(codec, TAIKO_A_CDC_RX2_VOL_CTL_B2_CTL, 
		headphone_volume_r + HEADPHONE_REG_OFFSET);

	// print debug info
	if (debug)
		printk("Black-Reactor-sound: headphone volume L=%d R=%d\n", headphone_volume_l, headphone_volume_r);

	return count;
}
// Debug status

static ssize_t debug_show(struct device *dev, struct device_attribute *attr, char *buf)
{
	// return current debug status
	return sprintf(buf, "Debug status: %d\n", debug);
}


static ssize_t debug_store(struct device *dev, struct device_attribute *attr,
						const char *buf, size_t count)
{
	unsigned int ret = -EINVAL;
	unsigned int val;

	// check data and store if valid
	ret = sscanf(buf, "%d", &val);

	if (ret != 1)
		return -EINVAL;
		
	if ((val == 0) || (val == 1))
		debug = val;

	return count;
}


// Register dump

static ssize_t register_dump_show(struct device *dev, struct device_attribute *attr, char *buf)
{
	// return current register values
	sprintf(buf, "Register dump\n");
	sprintf(buf+strlen(buf), "===================\n");

	// Output volumes Bank1
	sprintf(buf+strlen(buf), "** Output values bank 1\n");

	sprintf(buf+strlen(buf), "TAIKO_A_CDC_RX1_VOL_CTL_B1_CTL: %d\n", 
		taiko_read(codec, TAIKO_A_CDC_RX1_VOL_CTL_B1_CTL));

	sprintf(buf+strlen(buf), "TAIKO_A_CDC_RX2_VOL_CTL_B1_CTL: %d\n", 
		taiko_read(codec, TAIKO_A_CDC_RX2_VOL_CTL_B1_CTL));

	sprintf(buf+strlen(buf), "TAIKO_A_CDC_RX3_VOL_CTL_B1_CTL: %d\n", 
		taiko_read(codec, TAIKO_A_CDC_RX3_VOL_CTL_B1_CTL));

	sprintf(buf+strlen(buf), "TAIKO_A_CDC_RX4_VOL_CTL_B1_CTL: %d\n", 
		taiko_read(codec, TAIKO_A_CDC_RX4_VOL_CTL_B1_CTL));

	sprintf(buf+strlen(buf), "TAIKO_A_CDC_RX5_VOL_CTL_B1_CTL: %d\n", 
		taiko_read(codec, TAIKO_A_CDC_RX5_VOL_CTL_B1_CTL));

	sprintf(buf+strlen(buf), "TAIKO_A_CDC_RX6_VOL_CTL_B1_CTL: %d\n", 
		taiko_read(codec, TAIKO_A_CDC_RX6_VOL_CTL_B1_CTL));

	sprintf(buf+strlen(buf), "TAIKO_A_CDC_RX7_VOL_CTL_B1_CTL: %d\n", 
		taiko_read(codec, TAIKO_A_CDC_RX7_VOL_CTL_B1_CTL));

	// Output volumes Bank2
	sprintf(buf+strlen(buf), "\n** Output values bank 2\n");

	sprintf(buf+strlen(buf), "TAIKO_A_CDC_RX1_VOL_CTL_B2_CTL: %d (head l)\n", 
		taiko_read(codec, TAIKO_A_CDC_RX1_VOL_CTL_B2_CTL));

	sprintf(buf+strlen(buf), "TAIKO_A_CDC_RX2_VOL_CTL_B2_CTL: %d (head r)\n", 
		taiko_read(codec, TAIKO_A_CDC_RX2_VOL_CTL_B2_CTL));

	sprintf(buf+strlen(buf), "TAIKO_A_CDC_RX3_VOL_CTL_B2_CTL: %d (speaker)\n", 
		taiko_read(codec, TAIKO_A_CDC_RX3_VOL_CTL_B2_CTL));

	sprintf(buf+strlen(buf), "TAIKO_A_CDC_RX4_VOL_CTL_B2_CTL: %d (speaker)\n", 
		taiko_read(codec, TAIKO_A_CDC_RX4_VOL_CTL_B2_CTL));

	sprintf(buf+strlen(buf), "TAIKO_A_CDC_RX5_VOL_CTL_B2_CTL: %d\n", 
		taiko_read(codec, TAIKO_A_CDC_RX5_VOL_CTL_B2_CTL));

	sprintf(buf+strlen(buf), "TAIKO_A_CDC_RX6_VOL_CTL_B2_CTL: %d\n", 
		taiko_read(codec, TAIKO_A_CDC_RX6_VOL_CTL_B2_CTL));

	sprintf(buf+strlen(buf), "TAIKO_A_CDC_RX7_VOL_CTL_B2_CTL: %d\n", 
		taiko_read(codec, TAIKO_A_CDC_RX7_VOL_CTL_B2_CTL));

	// Input gains
	sprintf(buf+strlen(buf), "\n** Input gains\n");

	sprintf(buf+strlen(buf), "TAIKO_A_CDC_TX1_VOL_CTL_GAIN: %d\n", 
		taiko_read(codec, TAIKO_A_CDC_TX1_VOL_CTL_GAIN));

	sprintf(buf+strlen(buf), "TAIKO_A_CDC_TX2_VOL_CTL_GAIN: %d\n", 
		taiko_read(codec, TAIKO_A_CDC_TX2_VOL_CTL_GAIN));

	sprintf(buf+strlen(buf), "TAIKO_A_CDC_TX3_VOL_CTL_GAIN: %d\n", 
		taiko_read(codec, TAIKO_A_CDC_TX3_VOL_CTL_GAIN));

	sprintf(buf+strlen(buf), "TAIKO_A_CDC_TX4_VOL_CTL_GAIN: %d\n", 
		taiko_read(codec, TAIKO_A_CDC_TX4_VOL_CTL_GAIN));

	sprintf(buf+strlen(buf), "TAIKO_A_CDC_TX5_VOL_CTL_GAIN: %d\n", 
		taiko_read(codec, TAIKO_A_CDC_TX5_VOL_CTL_GAIN));

	sprintf(buf+strlen(buf), "TAIKO_A_CDC_TX6_VOL_CTL_GAIN: %d\n", 
		taiko_read(codec, TAIKO_A_CDC_TX6_VOL_CTL_GAIN));

	sprintf(buf+strlen(buf), "TAIKO_A_CDC_TX7_VOL_CTL_GAIN: %d\n", 
		taiko_read(codec, TAIKO_A_CDC_TX7_VOL_CTL_GAIN));

	sprintf(buf+strlen(buf), "TAIKO_A_CDC_TX8_VOL_CTL_GAIN: %d\n", 
		taiko_read(codec, TAIKO_A_CDC_TX8_VOL_CTL_GAIN));

	sprintf(buf+strlen(buf), "TAIKO_A_CDC_TX9_VOL_CTL_GAIN: %d\n", 
		taiko_read(codec, TAIKO_A_CDC_TX9_VOL_CTL_GAIN));

	sprintf(buf+strlen(buf), "TAIKO_A_CDC_TX10_VOL_CTL_GAIN: %d\n", 
		taiko_read(codec, TAIKO_A_CDC_TX10_VOL_CTL_GAIN));

	// return buffer length back
	return strlen(buf);
}


// Version information

static ssize_t version_show(struct device *dev, struct device_attribute *attr, char *buf)
{
	// return version information
	return sprintf(buf, "%s\n", BLACK_REACTOR_SOUND_VERSION);
}


/*****************************************/
// Initialize blackReactor sound sysfs folder
/*****************************************/

// define objects
static DEVICE_ATTR(blackReactor_sound, S_IRUGO | S_IWUGO, blackReactor_sound_show, blackReactor_sound_store);
static DEVICE_ATTR(headphone_volume, S_IRUGO | S_IWUGO, headphone_volume_show, headphone_volume_store);
static DEVICE_ATTR(debug, S_IRUGO | S_IWUGO, debug_show, debug_store);
static DEVICE_ATTR(register_dump, S_IRUGO | S_IWUGO, register_dump_show, NULL);
static DEVICE_ATTR(version, S_IRUGO | S_IWUGO, version_show, NULL);

// define attributes
static struct attribute *blackReactor_sound_attributes[] = {
	&dev_attr_blackReactor_sound.attr,
	&dev_attr_headphone_volume.attr,
	&dev_attr_debug.attr,
	&dev_attr_register_dump.attr,
	&dev_attr_version.attr,
	NULL
};

// define attribute group
static struct attribute_group blackReactor_sound_control_group = {
	.attrs = blackReactor_sound_attributes,
};

// define control device
static struct miscdevice blackReactor_sound_control_device = {
	.minor = MISC_DYNAMIC_MINOR,
	.name = "blackReactor_sound",
};


/*****************************************/
// Driver init and exit functions
/*****************************************/

static int blackReactor_sound_init(void)
{
	// register blackReactor sound control device
	misc_register(&blackReactor_sound_control_device);
	if (sysfs_create_group(&blackReactor_sound_control_device.this_device->kobj,
				&blackReactor_sound_control_group) < 0) {
		printk("Black-Reactor-sound: failed to create sys fs object.\n");
		return 0;
	}

	// Initialize variables
	blackReactor_sound = BLACK_REACTOR_SOUND_DEFAULT;
	debug = DEBUG_DEFAULT;
	
	// Reset blackReactor sound settings
	reset_blackReactor_sound();

	// Print debug info
	printk("Black-Reactor-sound: engine version %s started\n", BLACK_REACTOR_SOUND_VERSION);

	return 0;
}


static void blackReactor_sound_exit(void)
{
	// remove blackReactor sound control device
	sysfs_remove_group(&blackReactor_sound_control_device.this_device->kobj,
                           &blackReactor_sound_control_group);

	// Print debug info
	printk("Black-Reactor-sound: engine stopped\n");
}


/* define driver entry points */

module_init(blackReactor_sound_init);
module_exit(blackReactor_sound_exit);
