#!/bin/bash

# 1. Setup
export APP_ENV=dev
export DB_USER=myuser
export DB_PWD=mysecret
URL="https://node-envvars-artifact.s3.eu-west-2.amazonaws.com/bootcamp-node-envvars-project-1.0.0.tgz"

echo "Setting up node application...."
wget -q -O package.tgz "$URL"
tar -xzf package.tgz
cd package
npm install --quiet

# 2. Start Application
echo "Starting application...."
nohup node server.js > ../app.log 2>&1 &

# 3. Wait (Moved out of the comment so it actually runs)
sleep 5

echo "----------------------------------------------------"
echo "Checking Application Status:"
echo "----------------------------------------------------"

# 4. Check PID
APP_PID=$(pgrep -f "node server.js")

if [ -z "$APP_PID" ]; then
    echo "Error: The application process is not running."
    exit 1
else
    echo "Application is running with PID: $APP_PID"
fi

# 5. Check Port (Fixed column to $4 and fixed variable case)
# Note: sudo is often required for ss to see the PID/Process name
APP_PORT=$(sudo ss -lntp | grep "$APP_PID" | awk '{print $4}' | cut -d':' -f2)

if [ -z "$APP_PORT" ]; then
    echo "Warning: Could not detect the listening port."
else
    echo "Application is listening on port: $APP_PORT"
fi

echo "----------------------------------------------------"
