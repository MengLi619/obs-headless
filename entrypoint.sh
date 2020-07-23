#!/bin/sh

# Start XDummy in background
Xorg -noreset +extension GLX +extension RANDR +extension RENDER -config /etc/xorg.conf $DISPLAY

# Run grpc server
./run_server.sh
