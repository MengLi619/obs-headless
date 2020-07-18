#!/bin/bash

BUILD_DIR="build"
INSTALL_DIR=".."
BUILD_TYPE=Release
OBS_INSTALL_PATH="${HOME}/obs-studio-portable"

here=$(pwd)
cwd="${OBS_INSTALL_PATH}/bin/"
cd $cwd

echo "Current working directory (for core dumps etc): $cwd"

if [ "$1" == "-g" ]; then
    gdb ${here}/build/obs_headless_server
else
    ${here}/build/obs_headless_server
fi
