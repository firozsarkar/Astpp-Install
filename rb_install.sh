#!/bin/bash

echo "======================================"
echo " ASTPP Installation Script Starting "
echo "======================================"

# Go to source directory
cd /usr/src || exit 1

# Update system
echo "[1/5] Updating system..."
apt update -y

# Install required packages
echo "[2/5] Installing required packages..."
apt install -y wget curl sudo

# Download ASTPP installer
echo "[3/5] Downloading ASTPP install script..."
wget -O install.sh https://raw.githubusercontent.com/firozsarkar/Astpp-Install/refs/heads/main/install.sh

# Permission
echo "[4/5] Setting execute permission..."
chmod +x install.sh

# Start installation
echo "[5/5] Starting ASTPP installation..."
./install.sh

echo "======================================"
echo " ASTPP Installation Script Finished "
echo "======================================"
