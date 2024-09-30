#
# Copyright (C) 2024 The Android Open Source Project
# Copyright (C) 2024 SebaUbuntu's TWRP device tree generator
#
# SPDX-License-Identifier: Apache-2.0
#
LOCAL_PATH := device/google/husky
DEVICE_PATH := device/google/husky

TARGET_BOARD_KERNEL_HEADERS := device/google/shusky-kernel/kernel-headers

# Inherit from common AOSP config
$(call inherit-product, $(SRC_TARGET_DIR)/product/base.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit_only.mk)

# Inherit from the common Open Source product configuration
$(call inherit-product, $(SRC_TARGET_DIR)/product/aosp_base_telephony.mk)

# Inherit from virtual AB OTA config
$(call inherit-product, $(SRC_TARGET_DIR)/product/virtual_ab_ota.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/virtual_ab_ota/launch_with_vendor_ramdisk.mk)

# Enable project quotas and casefolding for emulated storage without sdcardfs
$(call inherit-product, $(SRC_TARGET_DIR)/product/emulated_storage.mk)

$(call inherit-product-if-exists, vendor/google_devices/husky/prebuilts/device-vendor-husky.mk)
$(call inherit-product-if-exists, vendor/google_devices/zuma/prebuilts/device-vendor.mk)
$(call inherit-product-if-exists, vendor/google_devices/zuma/proprietary/device-vendor.mk)
$(call inherit-product-if-exists, vendor/google_devices/husky/proprietary/husky/device-vendor-husky.mk)
$(call inherit-product-if-exists, vendor/google_devices/husky/proprietary/husky-vendor.mk)

#include device/google/shusky-sepolicy/husky-sepolicy.mk
#include device/google/zuma-sepolicy/zuma-sepolicy.mk

PRODUCT_PACKAGES += \
    linker.vendor_ramdisk \
    resize2fs.vendor_ramdisk \
    fsck.vendor_ramdisk \
    tune2fs.vendor_ramdisk

# Init files
PRODUCT_COPY_FILES += \
	device/google/husky/init.husky.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/hw/init.husky.rc \
	device/google/husky/recovery/root/init.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/hw/init.rc \
	device/google/husky/recovery/root/init.recovery.usb.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/hw/init.recovery.usb.rc \
	device/google/husky/recovery/root/citadeld.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/citadeld.rc \
	device/google/husky/recovery/root/servicemanager.recovery.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/servicemanager.recovery.rc \
	device/google/husky/recovery/root/android.hardware.health-service.zuma_recovery.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/android.hardware.health-service.zuma_recovery.rc \
	device/google/husky/recovery/root/android.hardware.boot-service.default_recovery-pixel.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/android.hardware.boot-service.default_recovery-pixel.rc \
	device/google/husky/recovery/root/android.hardware.security.keymint-service.citadel.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/android.hardware.security.keymint-service.citadel.rc \
	device/google/husky/recovery/root/android.hardware.security.keymint-service.rust.trusty.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/android.hardware.security.keymint-service.rust.trusty.rc \
	device/google/husky/recovery/root/system/etc/ueventd.rc:$(TARGET_COPY_OUT_VENDOR)/etc/ueventd.rc

# Device Manifest file
DEVICE_MANIFEST_FILE := \
device/google/husky/manifest.xml

#SHIPPING API
PRODUCT_SHIPPING_API_LEVEL := 32
PRODUCT_TARGET_VNDK_VERSION := 32

# define hardware platform
PRODUCT_PLATFORM := zuma

# A/B OTA
AB_OTA_UPDATER := true

PRODUCT_PACKAGES += \
    otapreopt_script \
    cppreopts.sh \
    checkpoint_gc \
    update_engine \
    update_engine_sideload \
    update_verifier

AB_OTA_POSTINSTALL_CONFIG += \
    RUN_POSTINSTALL_system=true \
    POSTINSTALL_PATH_system=system/bin/otapreopt_script \
    FILESYSTEM_TYPE_system=ext4 \
    POSTINSTALL_OPTIONAL_system=true

# Boot control HAL
PRODUCT_PACKAGES += \
    android.hardware.boot@1.2-impl \
    android.hardware.boot@1.2-impl.recovery \
    android.hardware.boot@1.2-impl-wrapper \
    android.hardware.boot@1.2-impl-wrapper.recovery \
    android.hardware.boot@1.2-service
PRODUCT_PACKAGES += \
    android.hardware.boot-service.default-pixel \
    android.hardware.boot-service.default_recovery-pixel

PRODUCT_PACKAGES += \
    bootctrl.zuma \
    bootctrl.zuma.recovery \
    bootctl

# Dynamic partitions
PRODUCT_USE_DYNAMIC_PARTITIONS := true

# fastbootd
PRODUCT_PACKAGES += \
    android.hardware.fastboot@1.1-impl-mock \
    android.hardware.fastboot@1.1-impl-mock.recovery \
    android.hardware.fastboot@1.1-impl.pixel \
    fastbootd

# vndservicemanager and vndservice no longer included in API 30+, however needed by vendor code.
PRODUCT_PACKAGES += vndservicemanager
PRODUCT_PACKAGES += vndservice

# Hidl Service
PRODUCT_ENFORCE_VINTF_MANIFEST := true
PRODUCT_PACKAGES += \
    libhidltransport.vendor \
    libhwbinder.vendor

# Display Config
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += ro.surface_flinger.ignore_hdr_camera_layers=true

PRODUCT_COPY_FILES += \
    device/google/husky/display_colordata_dev_cal0.pb:$(TARGET_COPY_OUT_VENDOR)/etc/display_colordata_dev_cal0.pb \
    device/google/husky/display_golden_google-hk3_cal0.pb:$(TARGET_COPY_OUT_VENDOR)/etc/display_golden_google-hk3_cal0.pb \
    device/google/husky/display_golden_external_display_cal2.pb:$(TARGET_COPY_OUT_VENDOR)/etc/display_golden_external_display_cal2.pb

# config of display brightness dimming
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += vendor.display.0.brightness.dimming.usage?=1
PRODUCT_VENDOR_PROPERTIES += \
    vendor.primarydisplay.op.hs_hz=120 \
    vendor.primarydisplay.op.ns_hz=60 \
    vendor.primarydisplay.op.ns_min_dbv=1172

# kernel idle timer for display driver
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += ro.surface_flinger.support_kernel_idle_timer=true

# lhbm peak brightness delay: decided by kernel
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += vendor.primarydisplay.lhbm.frames_to_reach_peak_brightness=0

# Display LBE
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += vendor.display.lbe.supported=1

# blocking zone for min idle refresh rate
PRODUCT_VENDOR_PROPERTIES += \
    vendor.primarydisplay.min_idle_refresh_rate.default=1 \
    vendor.primarydisplay.min_idle_refresh_rate.blocking_zone=10 \
    vendor.primarydisplay.min_idle_refresh_rate.blocking_zone_dbv=492

# Display ACL
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += vendor.display.0.brightness.acl.default=0

# display color data
PRODUCT_COPY_FILES += \
	device/google/shusky/husky/panel_config_google-hk3_cal0.pb:$(TARGET_COPY_OUT_VENDOR)/etc/panel_config_google-hk3_cal0.pb

# Display RRS default Config
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += persist.vendor.display.primary.boot_config=1008x2244@120
# TODO: b/250788756 - the property will be phased out after HWC loads user-preferred mode
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += vendor.display.preferred_mode=1008x2244@120

# Set support hide display cutout feature
PRODUCT_PRODUCT_PROPERTIES += \
    ro.support_hide_display_cutout=true

# Touch
PRODUCT_COPY_FILES += \
	frameworks/native/data/etc/android.hardware.touchscreen.multitouch.jazzhand.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.touchscreen.multitouch.jazzhand.xml

# USB HAL
PRODUCT_PACKAGES += \
	android.hardware.usb-service
PRODUCT_PACKAGES += \
	android.hardware.usb.gadget-service

# SecureElement
PRODUCT_PACKAGES += \
	android.hardware.secure_element@1.2-service-gto \
	android.hardware.secure_element@1.2-service-gto-ese2

# Vibrator HAL
ACTUATOR_MODEL := luxshare_ict_081545
ADAPTIVE_HAPTICS_FEATURE := adaptive_haptics_v1
PRODUCT_VENDOR_PROPERTIES += \
    persist.vendor.vibrator.hal.chirp.enabled=0 \
    ro.vendor.vibrator.hal.device.mass=0.222 \
    ro.vendor.vibrator.hal.loc.coeff=2.8 \
    persist.vendor.vibrator.hal.context.enable=false \
    persist.vendor.vibrator.hal.context.scale=60 \
    persist.vendor.vibrator.hal.context.fade=true \
    persist.vendor.vibrator.hal.context.cooldowntime=1600 \
    persist.vendor.vibrator.hal.context.settlingtime=5000 \
    ro.vendor.vibrator.hal.dbc.enable=true \
    ro.vendor.vibrator.hal.dbc.envrelcoef=8353728 \
    ro.vendor.vibrator.hal.dbc.riseheadroom=1909602 \
    ro.vendor.vibrator.hal.dbc.fallheadroom=1909602 \
    ro.vendor.vibrator.hal.dbc.txlvlthreshfs=2516583 \
    ro.vendor.vibrator.hal.dbc.txlvlholdoffms=0 \
    ro.vendor.vibrator.hal.pm.activetimeout=5

# Power HAL config
PRODUCT_COPY_FILES += \
	device/google/husky/powerhint.json:$(TARGET_COPY_OUT_VENDOR)/etc/powerhint.json

# PowerStats HAL
PRODUCT_SOONG_NAMESPACES += \
    device/google/husky/powerstats \
    device/google/husky

# Identity credential
PRODUCT_PACKAGES += \
    android.hardware.identity-support-lib.vendor:64 \
    android.hardware.identity_credential.xml

# Nos
PRODUCT_PACKAGES += \
    libkeymaster4support.vendor:64 \
    libkeymint_support.vendor:64 \
    libnos:64 \
    libnosprotos:64 \
    libnos_client_citadel:64 \
    libnos_datagram:64 \
    libnos_datagram_citadel:64 \
    libnos_transport:64 \
    nos_app_avb:64 \
    nos_app_identity:64 \
    nos_app_keymaster:64 \
    nos_app_weaver:64 \
    pixelpowerstats_provider_aidl_interface-cpp.vendor:64

# Misc interfaces
PRODUCT_PACKAGES += \
    android.frameworks.stats-V1-ndk.vendor:32 \
    android.hardware.authsecret@1.0.vendor:64 \
    android.hardware.biometrics.common-V2-ndk.vendor:64 \
    android.hardware.biometrics.face-V2-ndk.vendor:64 \
    android.hardware.biometrics.face@1.0.vendor:64 \
    android.hardware.biometrics.fingerprint-V2-ndk.vendor:64 \
    android.hardware.input.common-V1-ndk.vendor:64 \
    android.hardware.input.processor-V1-ndk.vendor:64 \
    android.hardware.keymaster@3.0.vendor:64 \
    android.hardware.keymaster@4.0.vendor:64 \
    android.hardware.keymaster@4.1.vendor:64 \
    android.hardware.neuralnetworks-V4-ndk.vendor:64 \
    android.hardware.oemlock@1.0.vendor:64 \
    android.hardware.power@1.0.vendor:64 \
    android.hardware.power@1.1.vendor:64 \
    android.hardware.power@1.2.vendor:64 \
    android.hardware.radio.config@1.0.vendor \
    android.hardware.radio.config@1.1.vendor \
    android.hardware.radio.config@1.2.vendor \
    android.hardware.radio.deprecated@1.0.vendor \
    android.hardware.radio@1.2.vendor \
    android.hardware.radio@1.3.vendor \
    android.hardware.radio@1.4.vendor \
    android.hardware.radio@1.5.vendor \
    android.hardware.radio@1.6.vendor \
    android.hardware.secure_element@1.0.vendor:32 \
    android.hardware.secure_element@1.1.vendor:32 \
    android.hardware.secure_element@1.2.vendor:32 \
    android.hardware.thermal@1.0.vendor:32 \
    android.hardware.thermal@2.0.vendor:32 \
    android.hardware.weaver@1.0.vendor:64 \
    android.hardware.wifi@1.1.vendor:64 \
    android.hardware.wifi@1.2.vendor:64 \
    android.hardware.wifi@1.3.vendor:64 \
    android.hardware.wifi@1.4.vendor:64 \
    android.hardware.wifi@1.5.vendor:64 \
    android.hardware.wifi@1.6.vendor:64 \
    com.google.hardware.pixel.display-V4-ndk.vendor:64 \
    com.google.hardware.pixel.display-V5-ndk.vendor \
    com.google.hardware.pixel.display-V6-ndk.vendor

# PowerStats HAL
PRODUCT_PACKAGES += \
	android.hardware.power.stats-service.pixel

PRODUCT_PACKAGES += \
	android.hardware.graphics.mapper@4.0-impl \
	android.hardware.graphics.allocator-V1-service

PRODUCT_PROPERTY_OVERRIDES += \
	debug.sf.disable_backpressure=0 \
	debug.sf.enable_gl_backpressure=1 \
	debug.sf.enable_sdr_dimming=1 \
	debug.sf.dim_in_gamma_in_enhanced_screenshots=1

PRODUCT_PROPERTY_OVERRIDES += \
	persist.sys.sf.native_mode=2

$(call soong_config_set,google_displaycolor,displaycolor_platform,zuma)
PRODUCT_PACKAGES += \
	android.hardware.composer.hwc3-service.pixel \
	libdisplaycolor \
	displaycolor_service

# Use FUSE passthrough
PRODUCT_PRODUCT_PROPERTIES += \
	persist.sys.fuse.passthrough.enable=true

# Touch service
include device/google/gs-common/touch/twoshay/aidl_zuma.mk

# vendor.display.config
RECOVERY_LIBRARY_SOURCE_FILES += \
    $(TARGET_OUT_SYSTEM_EXT_SHARED_LIBRARIES)/vendor.display.config@1.0.so \
    $(TARGET_OUT_SYSTEM_EXT_SHARED_LIBRARIES)/vendor.display.config@2.0.so

# Build libion
PRODUCT_PACKAGES += \
    libion

# Citadel
PRODUCT_PACKAGES += \
    citadeld \
    citadel_updater \
    android.hardware.authsecret-service.citadel \
    android.hardware.oemlock-service.citadel \
    android.hardware.weaver-service.citadel \
    android.hardware.security.keymint-service.citadel \
    android.hardware.identity-service.citadel \
    wait_for_strongbox

# Citadel debug stuff
PRODUCT_PACKAGES_DEBUG += \
    test_citadel

# Resume on Reboot support
PRODUCT_PACKAGES += \
    android.hardware.rebootescrow-service.citadel

# Keymaster configuration
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.device_id_attestation.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.software.device_id_attestation.xml \
    frameworks/native/data/etc/android.hardware.device_unique_attestation.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.device_unique_attestation.xml

# Identity
PRODUCT_PACKAGES += \
    android.hardware.identity-V5-ndk.vendor

# Keymaster
PRODUCT_PACKAGES += \
    android.hardware.hardware_keystore.xml \
    android.hardware.keymaster-V3-ndk.vendor \
    android.hardware.keymaster@4.1.vendor \
    libkeymaster_messages.vendor

# Keymint
PRODUCT_PACKAGES += \
    android.hardware.security.keymint-V1-ndk.vendor \
    android.hardware.security.keymint-V2-ndk.vendor \
    android.hardware.security.keymint-V3-ndk.vendor \
    android.hardware.security.rkp-V3-ndk.vendor \
    android.hardware.security.secureclock-V1-ndk.vendor \
    android.frameworks.stats-V1-ndk.vendor \
    android.hardware.security.sharedsecret-V1-ndk.vendor

# Device resolution
TARGET_SCREEN_WIDTH := 1344
TARGET_SCREEN_HEIGHT := 2992

# Pixelstats broken mic detection
PRODUCT_PROPERTY_OVERRIDES += vendor.audio.mic_break=true

# Project
include hardware/google/pixel/common/pixel-common-device.mk

# Factory OTA
-include vendor/google/factoryota/client/factoryota.mk

# storage
-include hardware/google/pixel/pixelstats/device.mk

# thermal
-include hardware/google/pixel/thermal/device.mk

# power HAL
-include hardware/google/pixel/power-libperfmgr/aidl/device.mk

# mm_event
-include hardware/google/pixel/mm/device.mk

# AIDL boot control
#-include device/google/gs-common/bootctrl/bootctrl_aidl.mk
#################################################################################
