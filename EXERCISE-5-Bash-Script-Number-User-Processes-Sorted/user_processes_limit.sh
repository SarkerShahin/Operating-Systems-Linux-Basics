#!/bin/bash

# Exercise 5: List processes for a specific user, sorted, with a limit
echo "Please enter the username:"
read USERNAME

echo "How many processes would you like to see?"
read PROCESS_COUNT

echo "--------------------------------------------------"
echo "Showing top $PROCESS_COUNT processes for user: $USERNAME"
echo "--------------------------------------------------"

# ps: lists processes
# -u: filters by user
# --sort=-pcpu: sorts by CPU usage descending
# head: limits the output (adding 1 to include the header)
ps -u "$USERNAME" --sort=-pcpu | head -n $((PROCESS_COUNT + 1))
