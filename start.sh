#!/usr/bin/env bash

set -o allexport
source .secret-env
set +o allexport

npm start
