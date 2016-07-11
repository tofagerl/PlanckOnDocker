#!/bin/sh
export QMK_DIR='/qmk/keyboards/planck'
export DOCKER_NAME='planck'

# Build the image from Dockerfile
docker build -t "${DOCKER_NAME}" .
#
# Run the script which makes all the firmware
docker run -it --rm --env QMK_DIR="$QMK_DIR" -v "$(pwd):/work" "${DOCKER_NAME}" "$QMK_DIR/make.sh"
