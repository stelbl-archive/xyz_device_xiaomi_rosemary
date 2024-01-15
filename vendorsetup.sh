#!/bin/bash

# Colors
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Function to display success message
success() {
    echo -e "${GREEN}$1${NC}"
}

# Function to display error message
error() {
    echo -e "${RED}$1${NC}"
}

# Cleanup
echo -e "\n${GREEN}Cleaning up.${NC}"
rm -rf device/mediatek/sepolicy_vndr

# Clone required repositories
echo -e "\n${GREEN}Cloning required repositories.${NC}"
git clone https://github.com/lineageos/android_device_mediatek_sepolicy_vndr device/mediatek/sepolicy_vndr
git clone https://github.com/xiaomi-mt6781-devs/android_hardware_mediatek hardware/mediatek
git clone https://github.com/cly-build/vendor-xiaomi-rosemary vendor/xiaomi/rosemary
git clone -b lineage-21 https://github.com/hannahmontanadeving/android_kernel_xiaomi_mt6785 --depth=1 --single-branch
git clone https://gitlab.com/xyzuniverse/android_vendor_xiaomi_rosemary-firmware vendor/xiaomi/rosemary-firmware

# Remove charger images on vendor
echo -e "\n${GREEN}Removing charger images on vendor.${NC}"
rm -rf vendor/*/charger

# Remove gnss on hardware/mediatek
echo -e "\n${GREEN}Removing gnss on hardware/mediatek.${NC}"
cd hardware/mediatek
rm -rf gnss*
rm -rf */gnss*
cd -

# Set up builder username and hostname
echo -e "\n${GREEN}Setting up builder username and hostname.${NC}"
export BUILD_USERNAME=rad
export BUILD_HOSTNAME=$(hostname)

# Display success message
success "Rosemary configuration setup, executed.!"
