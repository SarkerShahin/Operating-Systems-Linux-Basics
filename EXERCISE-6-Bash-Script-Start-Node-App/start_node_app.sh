#!/bin/bash

# 1. Install NodeJS and NPM
echo "Installing NodeJS and NPM...."
sudo apt update && sudo apt install -y nodejs npm


# Print versions
echo "Installed NodeJS version: $(node -v)"
echo "Installed NPM version: $(npm -v)"


# 2. Download the artifact
URL="https://node-envvars-artifact.s3.eu-west-2.amazonaws.com/bootcamp-node-envvars-project-1.0.0.tgz"
echo "Downloading artifact...."

wget $URL


# 3. Unzip the downloaded file
echo "Unzipping package...."
tar -xzvf bootcamp-node-envvars-project-1.0.0.tgz

# 4. Set environment variables
export APP_ENV=dev
export DB_USER=myuser
export DB_PWD=mysecret

# 5. Change into the package directory
cd package


# 6. Install dependencies and start the app in the background
echo "starting the nodeJS application in the background...."
# Using & to run in background and nohup to keep it running after terminal close
nohup node server.js &

echo "Application started. you can ignore the LOG_DIR warning for now."
