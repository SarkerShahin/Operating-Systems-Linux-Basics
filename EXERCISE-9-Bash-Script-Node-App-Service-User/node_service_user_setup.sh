#!/bin/bash

# 1. Define variables
SERVICE_USER="myapp"
LOG_DIR="/home/$SERVICE_USER/app-logs"
CURRENT_DIR=$(pwd)
URL="https://node-envvars-artifact.s3.eu-west-2.amazonaws.com/bootcamp-node-envvars-project-1.0.0.tgz"

echo "Step 1: Creating Service User: $SERVICE_USER"
if id "$SERVICE_USER" &>/dev/null; then
    echo "User $SERVICE_USER already exists."
else
    sudo useradd -m -r "$SERVICE_USER"
    echo "User $SERVICE_USER created."
fi

# 2. Setup Log Directory
echo "Step 2: Configuring Log Directory..."
sudo mkdir -p "$LOG_DIR"
sudo chown "$SERVICE_USER":"$SERVICE_USER" "$LOG_DIR"

# 3. Download and Setup App
echo "Step 3: Setting up application files..."
wget -q -O package-artifact.tgz "$URL"
sudo rm -rf package/
sudo tar -xzf package-artifact.tgz

# FIX: Change ownership BEFORE running npm install so it has permission
sudo chown -R $USER:$USER package/

echo "Installing application dependencies..."
cd package && npm install && cd ..

# Now ensure the SERVICE_USER owns everything for execution
sudo chown -R "$SERVICE_USER":"$SERVICE_USER" package/
sudo chmod -R 755 package/
chmod +x "$HOME"

# 4. Start Application
echo "Step 4: Starting application as '$SERVICE_USER'..."

# Clean up old processes
sudo pkill -u "$SERVICE_USER" -f "node" || true
sudo fuser -k 3000/tcp || true

# Run with absolute paths
sudo -u "$SERVICE_USER" bash -c "APP_ENV=dev DB_USER=myuser DB_PWD=mysecret LOG_DIR='$LOG_DIR' \
    nohup node '$CURRENT_DIR/package/server.js' > '$LOG_DIR/app_console.log' 2>&1 &"

echo "Waiting 10 seconds for application to initialize..."
sleep 10

# 5. Verification
echo "--------------------------------------------------------------------------------"
echo "Verification EXERCISE 9:"
echo "--------------------------------------------------------------------------------"

APP_PID=$(pgrep -u "$SERVICE_USER" node)

if [ -z "$APP_PID" ]; then
    echo "ERROR: Application failed to start as user $SERVICE_USER."
    echo "Check logs: sudo cat $LOG_DIR/app_console.log"
else
    RUNNING_AS=$(ps -o user= -p "$APP_PID" | xargs)
    echo "Application is running with PID: $APP_PID"
    echo "Running as user: $RUNNING_AS"

    if [ "$RUNNING_AS" == "$SERVICE_USER" ]; then
        echo "SUCCESS: Application is securely running under service user!"
    fi
fi
echo "--------------------------------------------------------------------------------"
