#!/bin/bash

echo "Updating system packages..."
sudo apt update

echo "Installing latest Java..."
sudo apt install openjdk-17-jdk -y

echo "Checking Java installation..."

JAVA_VERSION=$(java -version 2>&1 | awk -F '"' '/version/ {print $2}')

if [ -z "$JAVA_VERSION" ]; then
    echo "Java is NOT installed."
    exit 1
fi

MAJOR_VERSION=$(echo $JAVA_VERSION | awk -F. '{print $1}')

if [ "$MAJOR_VERSION" -lt 11 ]; then
    echo "Older Java version detected: $JAVA_VERSION"
elif [ "$MAJOR_VERSION" -ge 11 ]; then
    echo "Java installed successfully."
    echo "Java version: $JAVA_VERSION"
fi
