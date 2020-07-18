#!/bin/bash

. config.sh

here=$(pwd)
cwd="${OBS_INSTALL_PATH}/bin/"
cd $cwd

echo "Current working directory (for core dumps etc): $cwd"

# Fix "qt.qpa.xcb: could not connect to display"
# https://github.com/therecipe/qt/blob/master/internal/vagrant/pre.sh#L14-L20
export QT_QPA_PLATFORM=minimal

if [ "$1" == "-g" ]; then
    gdb ${here}/build/obs_headless_server
else
    ${here}/build/obs_headless_server
fi
