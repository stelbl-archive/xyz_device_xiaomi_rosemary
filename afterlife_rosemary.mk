#
# Copyright (C) 2023 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Inherit some common Afterlife stuff.
$(call inherit-product, vendor/afterlife/config/common_full_phone.mk)

# Inherit from rosemary device
$(call inherit-product, device/xiaomi/rosemary/device.mk)

# Flags prebuild lmc-camera
$(call inherit-product-if-exists, vendor/gcgop/config.mk)

# Misc Device Configuration
TARGET_SUPPORTS_GOOGLE_RECORDER := true
TARGET_INCLUDE_STOCK_ARCORE := true
TARGET_SUPPORTS_CALL_RECORDING := true

# After Life config
AFTERLIFE_GAPPS := true
AFTERLIFE_CORE := true
TARGET_SUPPORTS_BLUR := true
TARGET_FACE_UNLOCK_SUPPORTED := true
BUILD_AOSP_CAMERA := false
AFTERLIFE_MAINTAINER := zerorad

# Bootanimation
TARGET_BOOT_ANIMATION_RES := 1080
TARGET_SCREEN_HEIGHT := 2400
TARGET_SCREEN_WIDTH := 1080

PRODUCT_DEVICE := rosemary
PRODUCT_NAME := afterlife_rosemary
PRODUCT_BRAND := Redmi
PRODUCT_MODEL := Redmi Note 10S
PRODUCT_MANUFACTURER := Xiaomi

PRODUCT_GMS_CLIENTID_BASE := android-xiaomi

PRODUCT_BUILD_PROP_OVERRIDES += \
    PRIVATE_BUILD_DESC="rosemary-user 12 SP1A.210812.016 V13.0.5.0.SFFTWXM release-keys"

BUILD_FINGERPRINT := Redmi/rosemary/rosemary:12/SP1A.210812.016/V13.0.5.0.SFFTWXM:user/release-keys
