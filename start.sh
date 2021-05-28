#!/usr/bin/env bash

# Use environment variables from a secret file
set -o allexport
source .secret-env
set +o allexport

# Start the application
npm start
