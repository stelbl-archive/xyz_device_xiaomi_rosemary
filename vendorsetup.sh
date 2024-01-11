#!/bin/bash

echo "Cleaning up."
rm -rf device/mediatek/sepolicy_vndr

echo "Cloning required repositories."
git clone https://github.com/lineageos/android_device_mediatek_sepolicy_vndr device/mediatek/sepolicy_vndr
git clone https://github.com/xiaomi-mt6781-devs/android_hardware_mediatek hardware/mediatek
git clone https://github.com/cly-build/vendor-xiaomi-rosemary vendor/xiaomi/rosemary
git clone -b inline https://github.com/silont-project/kernel_xiaomi_rosemary kernel/xiaomi/rosemary --depth=1 --single-branch
git clone https://gitlab.com/xyzuniverse/android_vendor_xiaomi_rosemary-firmware vendor/xiaomi/rosemary-firmware

echo "Removing charger images on vendor."
rm -rf vendor/*/charger

echo "Removing gnss on hardware/mediatek"
cd hardware/mediatek
rm -rf gnss*
rm -rf */gnss*
cd -

echo "Setting up builder username and hostname."
export BUILD_USERNAME=rad
export BUILD_HOSTNAME=lazyer
