#!/bin/bash

## OrangeFox variables:
# General information
export FOX_VERSION="R11.1"
export OF_MAINTAINER="GamerBoy1234294"
export OF_MAINTAINER_AVATAR="device/google/husky/maintainer.png"

# Build environment stuffs
export FOX_BUILD_DEVICE="Pixel8Pro"
export ALLOW_MISSING_DEPENDENCIES=true
export FOX_USE_TWRP_RECOVERY_IMAGE_BUILDER=1
export TARGET_DEVICE_ALT="Pixel8Pro, GooglePixel8Pro, husky, Husky, shusky, Shusky"
export FOX_TARGET_DEVICES="Pixel8Pro, GooglePixel8Pro, husky, Husky, shusky, Shusky"

# Use magisk boot for patching
export OF_USE_MAGISKBOOT=1
export OF_USE_MAGISKBOOT_FOR_ALL_PATCHES=1

# Vanilla build
export FOX_VANILLA_BUILD=1

# We have A/B partition scheme
export FOX_AB_DEVICE=1
export FOX_VIRTUAL_AB_DEVICE=1

# Vendor Boot recovery
export FOX_VENDOR_BOOT_RECOVERY=1
export FOX_RECOVERY_VENDOR_BOOT_PARTITION="/dev/block/platform/13200000.ufs/by-name/vendor_boot"
export OF_NO_REFLASH_CURRENT_ORANGEFOX=1

# Screen specifications
export OF_STATUS_INDENT_LEFT=48
export OF_STATUS_INDENT_RIGHT=48
export OF_ALLOW_DISABLE_NAVBAR=0
export OF_CLOCK_POS=0
export OF_SCREEN_H=2400
export OF_STATUS_H=120

# Device stuff
export OF_KEEP_FORCED_ENCRYPTION=1
export OF_NO_TREBLE_COMPATIBILITY_CHECK=1
export OF_FBE_METADATA_MOUNT_IGNORE=1
export OF_USE_LEGACY_BATTERY_SERVICES=1

# Use updated binaries
export FOX_REPLACE_TOOLBOX_GETPROP=1
export FOX_BASH_TO_SYSTEM_BIN=1
export FOX_USE_UPDATED_MAGISKBOOT=1
export FOX_BUILD_BASH=1

# Run a process after formatting data to work-around MTP issues
export OF_RUN_POST_FORMAT_PROCESS=1

# Disable decryption
export OF_SKIP_FBE_DECRYPTION=1

# Use /data/recovery/Fox/ for Storage
export FOX_USE_DATA_RECOVERY_FOR_SETTINGS=1

export OF_QUICK_BACKUP_LIST="/boot;/init_boot;/data;"

# Magisk
export FOX_USE_SPECIFIC_MAGISK_ZIP=~/Magisk/Magisk-v28.0.zip

# Dont install AromaFM
export FOX_DELETE_AROMAFM=1

# Add some extras
export FOX_USE_ZIP_BINARY=1
export FOX_USE_TAR_BINARY=1
export FOX_USE_SED_BINARY=1
export FOX_USE_XZ_UTILS=1
export FOX_USE_LZ4_BINARY=1
export FOX_USE_ZSTD_BINARY=1
export FOX_REPLACE_BUSYBOX_PS=1
export FOX_USE_BUSYBOX_BINARY=1
export FOX_USE_BASH_SHELL=1
export OF_USE_LZ4_COMPRESSION=1 
export FOX_USE_NANO_EDITOR=1
export OF_DONT_KEEP_LOG_HISTORY=1
export OF_SUPPORT_ALL_BLOCK_OTA_UPDATES=0
export FOX_INSTALLER_DISABLE_AUTOREBOOT=1
export OF_DISABLE_MIUI_SPECIFIC_FEATURES=1
export FOX_REPLACE_TOOLBOX_GETPROP=1
export FOX_BASH_TO_SYSTEM_BIN=1
export FOX_ENABLE_APP_MANAGER=1
export FOX_VARIANT="default"
export OF_USE_GREEN_LED=1

## SkyHawk variables:
# Maintainer flags
export SHRP_MAINTAINER="GamerBoy1234294"

# Build environment stuff
export SHRP_DEVICE_CODE=husky
export ALLOW_MISSING_DEPENDENCIES=true
export SHRP_PATH=device/google/$SHRP_DEVICE_CODE

# Recovery Type (for "About" section only)
# Default (if not set): N/A
export SHRP_REC_TYPE=Normal

# Device Type (for "About" section only)
# Default (if not set): N/A
export SHRP_DEVICE_TYPE=A/B

# Your device's recovery path, dont use blindly
# Default (if not set): N/A
export SHRP_REC=/dev/block/platform/13200000.ufs/by-name/vendor_boot

# Use this flag only if SHRP_REC is set
# Default (if not set): N/A
export SHRP_HAS_RECOVERY_PARTITION=false

# Use this flag only if your device is A/B or Virtual A/B.
# Default (if not set): N/A
export SHRP_AB=true

# Emergency DownLoad mode (0 = no EDL mode, 1 = EDL mode available)
# Default (if not set): 0
export SHRP_EDL_MODE=0

# External SDcard path
# Default (if not set): /
export SHRP_EXTERNAL=/external_sd

# USB OTG path
# Default (if not set): /
export SHRP_OTG=/usb_otg

# SHRP padding flag (for rounded corner devices only)
# You have to change these values according to your device's roundness.
export SHRP_STATUSBAR_RIGHT_PADDING=48
# Default (for LEFT): 20
export SHRP_STATUSBAR_LEFT_PADDING=48

# For notch devices
# Default (if not set): N/A
export SHRP_NOTCH=false

# SHRP Dark mode, use this flag to have dark theme set by default
# Default (if not set) is not using DARK mode
export SHRP_DARK=true
