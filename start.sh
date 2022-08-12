#!/usr/bin/env bash

# Set a secret environment variable for the running application
set -o allexport
source ./.secret-env
set +o allexport

cat dockerfile-log.txt

echo "Hello from the shell 🐚"
echo "The value of the SECRET_PORT environment variable is: $SECRET_PORT"

# Start the application
export PRETEND_PRIVATE_KEY=$(cat pretend-private-key) && npm start
