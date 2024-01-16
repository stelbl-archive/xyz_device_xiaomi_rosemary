#!/bin/bash

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Function to display success message
success() {
    echo -e "${GREEN}$1${NC}"
}

# Function to display warning message
warning() {
    echo -e "${YELLOW}$1${NC}"
}

# Function to display error message
error() {
    echo -e "${RED}$1${NC}"
}

# Cleanup
rm -rf device/mediatek/sepolicy_vndr

# Repositories to clone with target directories
repos=(
    "https://github.com/lineageos/android_device_mediatek_sepolicy_vndr device/mediatek/sepolicy_vndr"
    "https://github.com/xiaomi-mt6781-devs/android_hardware_mediatek hardware/mediatek"
    "https://github.com/cly-build/vendor-xiaomi-rosemary vendor/xiaomi/rosemary"
    "https://github.com/hannahmontanadeving/android_kernel_xiaomi_mt6785 kernel/xiaomi/rosemary --depth=1 --single-branch -b lineage-21"
    "https://gitlab.com/xyzuniverse/android_vendor_xiaomi_rosemary-firmware vendor/xiaomi/rosemary-firmware"
    "https://bitbucket.org/saikrishna1504/vendor_miuicameraleica vendor/MiuiCameraLeica"
)

# Clone repositories
for repo in "${repos[@]}"; do
    target_dir=$(echo "$repo" | awk '{print $NF}')
    
    if [ -d "$target_dir" ]; then
        warning "Directory $target_dir already exists. Skipping clone."
    else
        echo -e "\n${GREEN}Cloning: $repo${NC}"
        git clone "$repo" || { error "Failed to clone $repo"; }
    fi
done

# Check if packages/apps/Aperture directory exists
if [ -d "packages/apps/Aperture" ]; then
    echo -e "Aperture detected! Removing..."
    rm -rf packages/apps/Aperture
else
    warning "Aperture not detected. Check if the package name is different or has changed."
fi

# Remove charger images on vendor
rm -rf vendor/*/charger

# Remove gnss on hardware/mediatek
cd hardware/mediatek || { error "Failed to enter hardware/mediatek directory"; }
rm -rf gnss*
rm -rf */gnss*
cd -

# Set up builder username and hostname
export BUILD_USERNAME=rad
export BUILD_HOSTNAME=$(hostname)

# Display success message
success "Script execution completed successfully."
