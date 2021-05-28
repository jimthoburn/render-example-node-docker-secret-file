#!/usr/bin/env bash

# Use environment variables from a secret file
set -o allexport
source .secret-env
set +o allexport

echo "The value of the “SECRET_PORT” environment variable is:"
echo $SECRET_PORT

# Start the application
npm start
