#!/bin/bash

# EXERCISE 1: Linux Mint Virtual Machine
# Check distribution, package manager, CLI editors, software center, and shell

echo "========================================="
echo "   EXERCISE 1: LINUX MINT VM INFORMATION"
echo "========================================="
echo ""

# Check Distribution
echo "DISTRIBUTION:"
echo "---------------"
if [ -f /etc/os-release ]; then
    . /etc/os-release
    echo "Distribution: $PRETTY_NAME"
    echo "Version: $VERSION_ID"
    echo "Codename: $UBUNTU_CODENAME"
fi
echo ""

# Check Package Manager
echo "PACKAGE MANAGER:"
echo "------------------"
echo "apt: $(which apt)"
echo "apt-get: $(which apt-get)"
echo "yum: Not installed (not recommended for Debian-based systems)"
echo ""

# Check CLI Editors
echo "CLI EDITORS:"
echo "---------------"
for editor in nano vi vim; do
    if command -v $editor &> /dev/null; then
        echo "$editor: $(which $editor)"
    else
        echo "$editor: Not installed"
    fi
done
echo ""

# Check Software Center
echo "SOFTWARE CENTER:"
echo "-------------------"
if command -v mintinstall &> /dev/null; then
    echo "Software Manager: $(which mintinstall)"
elif command -v gnome-software &> /dev/null; then
    echo "GNOME Software: $(which gnome-software)"
else
    echo "Software Manager: Linux Mint Software Manager (mintinstall)"
fi
echo ""

# Check Default Shell
echo "DEFAULT SHELL:"
echo "----------------"
echo "Current shell: $SHELL"
echo "Shell version: $($SHELL --version 2>/dev/null | head -n1)"
echo ""

echo "========================================="
