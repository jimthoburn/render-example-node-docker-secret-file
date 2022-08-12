#!/usr/bin/env bash

# Set a secret environment variable for the running application
set -o allexport
source ./.secret-env
set +o allexport

export PRETEND_PRIVATE_KEY=$(cat pretend-private-key)

cat dockerfile-log.txt

echo "Hello from the shell 🐚"
echo "The value of the SECRET_PORT environment variable is: $SECRET_PORT"
echo "The value of the PRETEND_PRIVATE_KEY environment variable is: $PRETEND_PRIVATE_KEY"

# Start the application
npm start
