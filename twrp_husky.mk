#
# Copyright (C) 2024 The Android Open Source Project
# Copyright (C) 2024 SebaUbuntu's TWRP device tree generator
#
# SPDX-License-Identifier: Apache-2.0
#

# Inherit device configuration
$(call inherit-product, device/google/husky/device.mk)
$(call inherit-product, device/google/zuma/lineage_common.mk)
$(call inherit-product, device/google/zuma/device-common.mk)
$(call inherit-product, device/google/gs-common/device.mk)

# Inherit some common recovery stuff
$(call inherit-product-if-exists, vendor/twrp/config/common.mk)
$(call inherit-product-if-exists, vendor/pb/config/common.mk)

PRODUCT_DEVICE := husky
PRODUCT_NAME := twrp_husky
PRODUCT_BRAND := google
PRODUCT_MODEL := Pixel 8 Pro
PRODUCT_MANUFACTURER := google

PRODUCT_GMS_CLIENTID_BASE := android-google

PRODUCT_BUILD_PROP_OVERRIDES += \
    PRIVATE_BUILD_DESC="husky-user 14 AP2A.240805.005 12025142 release-keys"

BUILD_FINGERPRINT := google/husky/husky:14/AP2A.240805.005/12025142:user/release-keys

include vendor/google/husky/husky-vendor.mk
