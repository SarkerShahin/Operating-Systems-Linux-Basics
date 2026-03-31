#!/bin/bash

echo "Current user: $USER"
echo "Processes running for this user:"

ps aux | grep $USER
