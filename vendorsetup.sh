#!/bin/bash

echo "Cleaning up."
rm -rf device/mediatek/sepolicy_vndr

echo "Cloning required repositories."
git clone https://github.com/lineageos/android_device_mediatek_sepolicy_vndr device/mediatek/sepolicy_vndr
git clone https://github.com/xiaomi-mt6781-devs/android_hardware_mediatek hardware/mediatek
git clone ssh://git@github.com/whoisgabutuniverseshit/proprietary_vendor_xiaomi_rosemary vendor/xiaomi/rosemary
git clone https://github.com/xiaomi-mt6785-dev/android_kernel_xiaomi_mt6785 kernel/xiaomi/rosemary --depth=1 --single-branch

echo "Removing charger images on vendor."
rm -rf vendor/*/charger

echo "Setting up builder username and hostname."
export BUILD_USERNAME=nobody
export BUILD_HOSTNAME=xyzuniverse

