#!/bin/bash


# 1. Define Log Directory  (Absolute path)

LOG_DIR_PATH="/home/sarker/.node_app_logs"

# FIX: Remove any existing file that might block directory creation
rm -rf "$LOG_DIR_PATH"
mkdir -p "$LOG_DIR_PATH"

# 2. Set Environment Variable

export APP_ENV=dev
export DB_USER=myuser
export DB_PWD=mysecret
export LOG_DIR="$LOG_DIR_PATH"

# 3. Setup Application

URL="https://node-envvars-artifact.s3.eu-west-2.amazonaws.com/bootcamp-node-envvars-project-1.0.0.tgz"
echo "Setting up Node application with LOG_DIR=$LOG_DIR_PATH"

# Clean old package if it exists
rm -rf package package-artifact.tgz

wget -q -O package-artifact.tgz "$URL"
tar -xzf package-artifact.tgz
cd package || exit 1 # Exit if cd fails
npm install --quiet

# 4. Start Application
echo "Starting application in background..."
# Using the absolute path for redirection is much safer
nohup node server.js > "$LOG_DIR_PATH/app_console.log" 2>&1 &

sleep 5

# 5. Verify
echo "======================================================"
# Check for the file specifically, not just the directory
if [ -f "$LOG_DIR_PATH/app_console.log" ]; then
	echo "SUCCESS: Log file created at $LOG_DIR_PATH"/app_console.log"
	echo "Process ID:$(pgrep-f 'node server.js')"
	ls -l "LOG_DIR_PATH"
	
 
else
    echo"ERROR: Log file was not created.Check permission for $LOG_DIR_PATH"
fi
echo "================================================="
