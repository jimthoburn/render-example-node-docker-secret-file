#!/usr/bin/env bash

# Set a secret environment variable for the running application
set -o allexport
source ./.secret-env
set +o allexport

cat $HELLO_FROM_DOCKER_FILE_PATH
cat dockerfile-log.txt

echo "Hello from the shell 🐚"
echo "The value of the SECRET_PORT environment variable is: $SECRET_PORT"
echo "The value of the PUBLIC_PORT environment variable is: $PUBLIC_PORT"
echo "The value of the PUBLIC_MESSAGE environment variable is: $PUBLIC_MESSAGE"
echo "The value of the HELLO_FROM_DOCKER_FILE_PATH environment variable is: $HELLO_FROM_DOCKER_FILE_PATH"

# Start the application
npm start
