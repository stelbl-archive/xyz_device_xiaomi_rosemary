#!/bin/bash

echo "Cleaning up."
rm -rf device/mediatek/sepolicy_vndr

echo "Cloning required repositories."
git clone https://github.com/lineageos/android_device_mediatek_sepolicy_vndr device/mediatek/sepolicy_vndr

echo "Removing charger images on vendor."
rm -rf vendor/*/charger

echo "Setting up builder username and hostname."
export BUILD_USERNAME=nobody
export BUILD_HOSTNAME=xyzuniverse

