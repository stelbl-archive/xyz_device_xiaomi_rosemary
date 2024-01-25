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

# Clone repository function
clone_repository() {
    repo_url="$1"
    target_dir="$2"
    args="${@:3}"  # Capture additional arguments

    if [ -d "$target_dir" ]; then
        warning "Directory $target_dir already exists. Skipping clone."
    else
        echo -e "\n${GREEN}Cloning: $repo_url${NC}"
        git clone $args "$repo_url" "$target_dir" || { error "Failed to clone $repo_url"; }
        
        # After cloning, set branch if applicable
        if [[ "$args" == *"-b "* ]]; then
            branch=$(echo "$args" | grep -oP -- "-b \K[^ ]*")
            cd "$target_dir" || return
            git checkout "$branch"
            cd - || return
        fi
    fi
}

# Clone repositories one by one
clone_repository "https://github.com/lineageos/android_device_mediatek_sepolicy_vndr" "device/mediatek/sepolicy_vndr"
clone_repository "https://github.com/xiaomi-mt6781-devs/android_hardware_mediatek" "hardware/mediatek"
clone_repository "https://github.com/Sicantik-Hanya-Gabut/vt" "vendor/xiaomi/rosemary"
clone_repository "https://github.com/hannahmontanadeving/android_kernel_xiaomi_mt6785" "kernel/xiaomi/rosemary" "--depth=1 --single-branch -b lineage-21"
clone_repository "https://gitlab.com/xyzuniverse/android_vendor_xiaomi_rosemary-firmware" "vendor/xiaomi/rosemary-firmware"
clone_repository "https://bitbucket.org/saikrishna1504/vendor_miuicameraleica" "vendor/MiuiCameraLeica"

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
