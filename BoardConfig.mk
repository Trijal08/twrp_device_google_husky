#
# Copyright (C) 2024 The Android Open Source Project
# Copyright (C) 2024 SebaUbuntu's TWRP device tree generator
#
# SPDX-License-Identifier: Apache-2.0
#

DEVICE_PATH := device/google/husky

include device/google/zuma/BoardConfig-common.mk
include vendor/google_devices/husky/BoardConfigVendor.mk

TARGET_BOARD_INFO_FILE := device/google/husky/board-info.txt
TARGET_BOOTLOADER_BOARD_NAME := husky

# For building with minimal manifest
ALLOW_MISSING_DEPENDENCIES := true

# 12.1 manifest requirements
TARGET_SUPPORTS_64_BIT_APPS := true
BUILD_BROKEN_DUP_RULES := true
BUILD_BROKEN_ELF_PREBUILT_PRODUCT_COPY_FILES := true
BUILD_BROKEN_MISSING_REQUIRED_MODULES := true

# A/B
AB_OTA_UPDATER := true
AB_OTA_PARTITIONS += \
    vendor_dlkm \
    init_boot \
    system \
    product \
    system_ext \
    system_dlkm \
    vbmeta \
    vendor \
    boot

# Architecture
TARGET_SOC := zuma

TARGET_SOC_NAME := google

USES_DEVICE_GOOGLE_ZUMA := true
USES_DEVICE_GOOGLE_HUSKY := true
USES_DEVICE_GOOGLE_SHUSKY := true

TARGET_ARCH := arm64
TARGET_ARCH_VARIANT := armv8-2a
TARGET_CPU_ABI := arm64-v8a
TARGET_CPU_VARIANT := cortex-a55
TARGET_CPU_VARIANT_RUNTIME := cortex-a55

# APEX
DEXPREOPT_GENERATE_APEX_IMAGE := true

# Bootloader
TARGET_BOOTLOADER_BOARD_NAME := husky
TARGET_NO_BOOTLOADER := true

# Display
TARGET_SCREEN_DENSITY := 480
TARGET_USES_VULKAN := true

# Kernel
BOARD_BOOTIMG_HEADER_VERSION := 4
BOARD_KERNEL_BASE := 0x10000000
BOARD_KERNEL_CMDLINE := exynos_drm.load_sequential=1 g2d.load_sequential=1 samsung_iommu_v9.load_sequential=1 swiotlb=noforce disable_dma32=on earlycon=exynos4210,0x10870000 console=ttySAC0,115200 androidboot.console=ttySAC0 printk.devkmsg=on cma_sysfs.experimental=Y cgroup_disable=memory rcupdate.rcu_expedited=1 rcu_nocbs=all swiotlb=1024 cgroup.memory=nokmem sysctl.kernel.sched_pelt_multiplier=4 kasan=off at24.write_timeout=100 log_buf_len=1024K bootconfig
BOARD_KERNEL_PAGESIZE := 2048
BOARD_RAMDISK_OFFSET := 0x01000000
BOARD_KERNEL_TAGS_OFFSET := 0x00000100
BOARD_MKBOOTIMG_ARGS += --header_version $(BOARD_BOOTIMG_HEADER_VERSION)
BOARD_MKBOOTIMG_ARGS += --ramdisk_offset $(BOARD_RAMDISK_OFFSET)
BOARD_MKBOOTIMG_ARGS += --tags_offset $(BOARD_KERNEL_TAGS_OFFSET)
BOARD_KERNEL_IMAGE_NAME := Image
TARGET_KERNEL_CONFIG := zuma_defconfig
TARGET_KERNEL_SOURCE := kernel/google/zuma/private/soc/gs

# Kernel - prebuilt
TARGET_FORCE_PREBUILT_KERNEL := true
ifeq ($(TARGET_FORCE_PREBUILT_KERNEL),true)
TARGET_PREBUILT_KERNEL := $(DEVICE_PATH)/prebuilt/kernel
endif

# Partitions
BOARD_FLASH_BLOCK_SIZE := 131072 # (BOARD_KERNEL_PAGESIZE * 64)
BOARD_BOOTIMAGE_PARTITION_SIZE := 67108864
BOARD_VENDOR_BOOTIMAGE_PARTITION_SIZE := 67108864
BOARD_RECOVERYIMAGE_PARTITION_SIZE := 67108864
BOARD_HAS_LARGE_FILESYSTEM := true
BOARD_SYSTEMIMAGE_PARTITION_TYPE := ext4
BOARD_USERDATAIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE := ext4
TARGET_COPY_OUT_VENDOR := vendor
BOARD_SUPER_PARTITION_SIZE := 9126805504 # TODO: Fix hardcoded value
BOARD_SUPER_PARTITION_GROUPS := google_dynamic_partitions
BOARD_GOOGLE_DYNAMIC_PARTITIONS_PARTITION_LIST := system system_ext product vendor vendor_dlkm
BOARD_GOOGLE_DYNAMIC_PARTITIONS_SIZE := 9122611200 # TODO: Fix hardcoded value

VENDOR_CMDLINE := "dyndbg=\"func alloc_contig_dump_pages +p\" \
                earlycon=exynos4210,0x10A00000 console=ttySAC0,115200 androidboot.console=ttySAC0 printk.devkmsg=on \
                swiotlb=noforce \
		cma_sysfs.experimental=Y \
		cgroup_disable=memory \
		rcupdate.rcu_expedited=1 \
		rcu_nocbs=all \
		stack_depot_disable=off \
		page_pinner=on \
		swiotlb=1024 \
		disable_dma32=on \
                at24.write_timeout=100 \
		log_buf_len=1024K \
		bootconfig"

BOARD_BOOTCONFIG += androidboot.load_modules_parallel=true
BOARD_KERNEL_CMDLINE += exynos_drm.load_sequential=1

# Kernel
BOARD_KERNEL_BASE        := 0x1000000
BOARD_KERNEL_PAGESIZE    := 2048
BOARD_KERNEL_OFFSET      := 0x00008000
BOARD_RAMDISK_OFFSET     := 0x01000000
BOARD_KERNEL_TAGS_OFFSET := 0x00000100
BOARD_DTB_OFFSET         := 0x01f00000

# vendor_boot as recovery
BOARD_BOOT_HEADER_VERSION := 4
BOARD_USES_RECOVERY_AS_BOOT := false
BOARD_INCLUDE_RECOVERY_RAMDISK_IN_VENDOR_BOOT := true
BOARD_MOVE_RECOVERY_RESOURCES_TO_VENDOR_BOOT := true
BOARD_EXCLUDE_KERNEL_FROM_RECOVERY_IMAGE := false
BOARD_USES_GENERIC_KERNEL_IMAGE := true
BOARD_MOVE_GSI_AVB_KEYS_TO_VENDOR_BOOT := true
BOARD_INCLUDE_DTB_IN_BOOTIMG := true
BOARD_KERNEL_IMAGE_NAME := Image.lz4
TARGET_KERNEL_CONFIG := zuma_defconfig
TARGET_KERNEL_SOURCE := kernel/google/zuma/private/soc/gs
TARGET_PREBUILT_KERNEL := $(DEVICE_PATH)/prebuilt/Image
BOARD_PREBUILT_DTBIMAGE_DIR := $(DEVICE_PATH)/prebuilt/dtbs
BOARD_PREBUILT_DTBOIMAGE := $(DEVICE_PATH)/prebuilt/dtbo.img
BOARD_MKBOOTIMG_ARGS += --base $(BOARD_KERNEL_BASE)
BOARD_MKBOOTIMG_ARGS += --pagesize $(BOARD_KERNEL_PAGESIZE)
BOARD_MKBOOTIMG_ARGS += --ramdisk_offset $(BOARD_RAMDISK_OFFSET)
BOARD_MKBOOTIMG_ARGS += --tags_offset $(BOARD_KERNEL_TAGS_OFFSET)
BOARD_MKBOOTIMG_ARGS += --kernel_offset $(BOARD_KERNEL_OFFSET)
BOARD_MKBOOTIMG_ARGS += --header_version $(BOARD_BOOT_HEADER_VERSION) 
BOARD_MKBOOTIMG_ARGS += --dtb_offset $(BOARD_DTB_OFFSET)
BOARD_MKBOOTIMG_ARGS += --vendor_cmdline $(VENDOR_CMDLINE)

# Platform
TARGET_BOARD_PLATFORM := zuma

# Recovery
TARGET_RECOVERY_PIXEL_FORMAT := ABGR_8888
TARGET_USERIMAGES_USE_EXT4 := true
TARGET_USERIMAGES_USE_F2FS := true

# Security patch level
VENDOR_SECURITY_PATCH := 2021-08-01

# Verified Boot
BOARD_AVB_ENABLE := true
BOARD_AVB_MAKE_VBMETA_IMAGE_ARGS += --flags 3

# Hack: prevent anti rollback
PLATFORM_SECURITY_PATCH := 2099-12-31# 12.1 manifest requirements
TARGET_SUPPORTS_64_BIT_APPS := true
BUILD_BROKEN_DUP_RULES := true
BUILD_BROKEN_ELF_PREBUILT_PRODUCT_COPY_FILES := true
BUILD_BROKEN_MISSING_REQUIRED_MODULES := true
VENDOR_SECURITY_PATCH := 2099-12-31
PLATFORM_VERSION := 16.1.0

# Load Touch modules files
PRODUCT_COPY_FILES += \
    device/google/husky/prebuilt/android.hardware.gatekeeper@1.0-service-qti:$(TARGET_COPY_OUT_RECOVERY)/root/system/bin/android.hardware.gatekeeper@1.0-service-qti \
    device/google/husky/prebuilt/android.hardware.keymaster@4.1-service.citadel:$(TARGET_COPY_OUT_RECOVERY)/root/system/bin/android.hardware.keymaster@4.1-service.citadel \
    device/google/husky/prebuilt/citadeld::$(TARGET_COPY_OUT_RECOVERY)/root/system/bin/citadeld \
    device/google/husky/prebuilt/qseecomd::$(TARGET_COPY_OUT_RECOVERY)/root/system/bin/qseecomd \
    device/google/husky/prebuilt/android.hardware.keymaster@4.0-service-qti:$(TARGET_COPY_OUT_RECOVERY)/root/system/bin/android.hardware.keymaster@4.0-service-qti \
    device/google/husky/prebuilt/android.hardware.weaver@1.0-service.citadel:$(TARGET_COPY_OUT_RECOVERY)/root/system/bin/android.hardware.weaver@1.0-service.citadel \
    device/google/husky/prebuilt/time_daemon:$(TARGET_COPY_OUT_RECOVERY)/root/system/bin/time_daemon \
    device/google/husky/prebuilt/compatibility_matrix.1.xml:$(TARGET_COPY_OUT_RECOVERY)/root/system/etc/vintf/compatibility_matrix.1.xml \
    device/google/husky/prebuilt/compatibility_matrix.5.xml:$(TARGET_COPY_OUT_RECOVERY)/root/system/etc/vintf/compatibility_matrix.5.xml \
    device/google/husky/prebuilt/compatibility_matrix.2.xml:$(TARGET_COPY_OUT_RECOVERY)/root/system/etc/vintf/compatibility_matrix.2.xml \
    device/google/husky/prebuilt/compatibility_matrix.legacy.xml:$(TARGET_COPY_OUT_RECOVERY)/root/system/etc/vintf/compatibility_matrix.legacy.xml \
    device/google/husky/prebuilt/compatibility_matrix.3.xml:$(TARGET_COPY_OUT_RECOVERY)/root/system/etc/vintf/compatibility_matrix.3.xml \
    device/google/husky/prebuilt/compatibility_matrix.xml:$(TARGET_COPY_OUT_RECOVERY)/root/system/etc/vintf/compatibility_matrix.xml \
    device/google/husky/prebuilt/compatibility_matrix.4.xml:$(TARGET_COPY_OUT_RECOVERY)/root/system/etc/vintf/compatibility_matrix.4.xml \
    device/google/husky/prebuilt/systemmanifest.xml:$(TARGET_COPY_OUT_RECOVERY)/root/system/etc/vintf/manifest.xml \
    device/google/husky/prebuilt/vendormanifest.xml:$(TARGET_COPY_OUT_RECOVERY)/root/vendor/etc/vintf/manifest.xml \
    device/google/husky/prebuilt/libqtikeymaster4.so:$(TARGET_COPY_OUT_RECOVERY)/root/system/lib64/libqtikeymaster4.so \
    device/google/husky/prebuilt/libkeymasterdeviceutils.so:$(TARGET_COPY_OUT_RECOVERY)/root/system/lib64/libkeymasterdeviceutils.so \
    device/google/husky/prebuilt/libkeymasterutils.so:$(TARGET_COPY_OUT_RECOVERY)/root/system/lib64/libkeymasterutils.so \
    device/google/husky/prebuilt/libnosprotos.so:$(TARGET_COPY_OUT_RECOVERY)/root/system/lib64/libnosprotos.so \
    device/google/husky/prebuilt/vendor-pixelatoms-cpp.so:$(TARGET_COPY_OUT_RECOVERY)/root/system/lib64/vendor-pixelatoms-cpp.so \
    device/google/husky/prebuilt/libQSEEComAPI.so:$(TARGET_COPY_OUT_RECOVERY)/root/system/lib64/libQSEEComAPI.so \
    device/google/husky/prebuilt/android.hardware.authsecret@1.0-impl.nos.so:$(TARGET_COPY_OUT_RECOVERY)/root/system/lib64/android.hardware.authsecret@1.0-impl.nos.so \
    device/google/husky/prebuilt/libprotobuf-cpp-full-3.9.1.so:$(TARGET_COPY_OUT_RECOVERY)/root/system/lib64/libprotobuf-cpp-full-3.9.1.so \
    device/google/husky/prebuilt/libqcbor.so:$(TARGET_COPY_OUT_RECOVERY)/root/system/lib64/libqcbor.so \
    device/google/husky/prebuilt/libdiag.so:$(TARGET_COPY_OUT_RECOVERY)/root/system/lib64/libdiag.so \
    device/google/husky/prebuilt/libnos_citadeld_proxy.so:$(TARGET_COPY_OUT_RECOVERY)/root/system/lib64/libnos_citadeld_proxy.so \
    device/google/husky/prebuilt/libnos_client_citadel.so:$(TARGET_COPY_OUT_RECOVERY)/root/system/lib64/libnos_client_citadel.so \
    device/google/husky/prebuilt/nos_app_avb.so:$(TARGET_COPY_OUT_RECOVERY)/root/system/lib64/nos_app_avb.so \
    device/google/husky/prebuilt/nos_app_keymaster.so:$(TARGET_COPY_OUT_RECOVERY)/root/system/lib64/nos_app_keymaster.so \
    device/google/husky/prebuilt/libprotobuf-cpp-lite-3.9.1.so:$(TARGET_COPY_OUT_RECOVERY)/root/system/lib64/libprotobuf-cpp-lite-3.9.1.so \
    device/google/husky/prebuilt/nos_app_weaver.so:$(TARGET_COPY_OUT_RECOVERY)/root/system/lib64/nos_app_weaver.so \
    device/google/husky/prebuilt/libnos_datagram_citadel.so:$(TARGET_COPY_OUT_RECOVERY)/root/system/lib64/libnos_datagram_citadel.so \
    device/google/husky/prebuilt/android.hardware.keymaster@4.1-impl.nos.so:$(TARGET_COPY_OUT_RECOVERY)/root/system/lib64/android.hardware.keymaster@4.1-impl.nos.so \
    device/google/husky/prebuilt/android.hardware.weaver@1.0-impl.nos.so:$(TARGET_COPY_OUT_RECOVERY)/root/system/lib64/android.hardware.weaver@1.0-impl.nos.so \
    device/google/husky/prebuilt/android.hardware.oemlock@1.0-impl.nos.so:$(TARGET_COPY_OUT_RECOVERY)/root/system/lib64/android.hardware.oemlock@1.0-impl.nos.so \
    device/google/husky/prebuilt/pixelpowerstats_provider_aidl_interface-V1-cpp.so:$(TARGET_COPY_OUT_RECOVERY)/root/system/lib64/pixelpowerstats_provider_aidl_interface-V1-cpp.so \
    device/google/husky/prebuilt/libnos.so:$(TARGET_COPY_OUT_RECOVERY)/root/system/lib64/libnos.so \
    device/google/husky/prebuilt/libqmi_cci.so:$(TARGET_COPY_OUT_RECOVERY)/root/system/lib64/libqmi_cci.so \
    device/google/husky/prebuilt/librpmb.so:$(TARGET_COPY_OUT_RECOVERY)/root/system/lib64/librpmb.so \
    device/google/husky/prebuilt/libssd.so:$(TARGET_COPY_OUT_RECOVERY)/root/system/lib64/libssd.so \
    device/google/husky/prebuilt/libops.so:$(TARGET_COPY_OUT_RECOVERY)/root/system/lib64/libops.so \
    device/google/husky/prebuilt/libdisplayconfig.qti.so:$(TARGET_COPY_OUT_RECOVERY)/root/system/lib64/libdisplayconfig.qti.so \
    device/google/husky/prebuilt/libGPreqcancel.so:$(TARGET_COPY_OUT_RECOVERY)/root/system/lib64/libGPreqcancel.so \
    device/google/husky/prebuilt/libqisl.so:$(TARGET_COPY_OUT_RECOVERY)/root/system/lib64/libqisl.so \
    device/google/husky/prebuilt/libGPreqcancel_svc.so:$(TARGET_COPY_OUT_RECOVERY)/root/system/lib64/libGPreqcancel_svc.so \
    device/google/husky/prebuilt/libsecureui.so:$(TARGET_COPY_OUT_RECOVERY)/root/system/lib64/libsecureui.so \
    device/google/husky/prebuilt/libqmi_common_so.so:$(TARGET_COPY_OUT_RECOVERY)/root/system/lib64/libqmi_common_so.so \
    device/google/husky/prebuilt/libStDrvInt.so:$(TARGET_COPY_OUT_RECOVERY)/root/system/lib64/libStDrvInt.so \
    device/google/husky/prebuilt/libtime_genoff.so:$(TARGET_COPY_OUT_RECOVERY)/root/system/lib64/libtime_genoff.so \
    device/google/husky/prebuilt/libqmi_encdec.so:$(TARGET_COPY_OUT_RECOVERY)/root/system/lib64/libqmi_encdec.so \
    device/google/husky/prebuilt/android.hardware.gatekeeper@1.0-impl-qti.so:$(TARGET_COPY_OUT_RECOVERY)/root/vendor/lib64/hw/android.hardware.gatekeeper@1.0-impl-qti.so \
    device/google/husky/prebuilt/prepdecrypt.sh:$(TARGET_COPY_OUT_RECOVERY)/root/system/bin/prepdecrypt.sh
TW_LOAD_VENDOR_MODULES := "heatmap.ko touch_offload.ko ftm5.ko sec_touch.ko goodix_brl_touch.ko goog_touch_interface.ko"

# TWRP specific build flags
TWRP_EVENT_LOGGING := true
TWRP_INCLUDE_LOGCAT := true
TARGET_USES_LOGD := true
TW_THEME := portrait_hdpi
TW_USE_SERIALNO_PROPERTY_FOR_DEVICE_ID := true
TW_EXTRA_LANGUAGES := true
TW_NO_SCREEN_BLANK := true
TW_NO_SCREEN_TIMEOUT := true
#TW_INPUT_BLACKLIST := "accelerometer"
#TW_INPUT_BLACKLIST := "gyroscope"
TW_INPUT_BLACKLIST := "hbtp_vm"
TW_MAX_BRIGHTNESS := 520
TW_INCLUDE_FASTBOOTD := true
TARGET_USE_CUSTOM_LUN_FILE_PATH := /config/usb_gadget/g1/functions/mass_storage.0/lun.%d/file
TW_USE_TOOLBOX := true
TW_INCLUDE_REPACKTOOLS := true
TARGET_SYSTEM_PROP += $(DEVICE_PATH)/system.prop
TW_EXCLUDE_DEFAULT_USB_INIT := true
TW_INCLUDE_RESETPROP := true
TW_EXCLUDE_APEX := true
TW_SUPPORT_INPUT_AIDL_HAPTICS := true
#TW_USE_CRYPTO := true
TW_Y_OFFSET := 80
TW_H_OFFSET := -80
TW_OVERRIDE_SYSTEM_PROPS := \ 
"ro.bootimage.build.date.utc=ro.build.date.utc;ro.build.date.utc;ro.odm.build.date.utc=ro.build.date.utc;ro.product.build.date.utc=ro.build.date.utc;ro.system.build.date.utc=ro.build.date.utc;ro.system_ext.build.date.utc=ro.build.date.utc;ro.vendor.build.date.utc=ro.build.date.utc;ro.build.product;ro.build.fingerprint=ro.system.build.fingerprint;ro.build.version.incremental;ro.product.name=ro.product.system.name"
