#!/usr/bin/env bash

# Set a secret environment variable for the running application
set -o allexport
source ./.secret-env
set +o allexport

cat dockerfile-log.txt

echo "Hello from the shell 🐚"
echo "The value of the SECRET_PORT environment variable is: $SECRET_PORT"
echo "The value of the PUBLIC_PORT environment variable is: $PUBLIC_PORT"
echo "The value of the PUBLIC_MESSAGE environment variable is: $PUBLIC_MESSAGE"

# Start the application
npm start
