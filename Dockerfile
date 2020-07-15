FROM ubuntu:20.04 as build
ARG OBS_VERSION=23.2.1

# Setup timezone
ENV TZ=Asia/Shanghai
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install git grpc
RUN apt-get update && \
    apt-get install -y \
    build-essential \
    checkinstall \
    cmake \
    git \
    libmbedtls-dev \
    libasound2-dev \
    libavcodec-dev \
    libavdevice-dev \
    libavfilter-dev \
    libavformat-dev \
    libavutil-dev \
    libcurl4-openssl-dev \
    libfdk-aac-dev \
    libfontconfig-dev \
    libfreetype6-dev \
    libgl1-mesa-dev \
    libjack-jackd2-dev \
    libjansson-dev \
    libluajit-5.1-dev \
    libpulse-dev \
    libqt5x11extras5-dev \
    libspeexdsp-dev \
    libswresample-dev \
    libswscale-dev \
    libudev-dev \
    libv4l-dev \
    libvlc-dev \
    libx11-dev \
    libx264-dev \
    libxcb-shm0-dev \
    libxcb-xinerama0-dev \
    libxcomposite-dev \
    libxinerama-dev \
    pkg-config \
    python3-dev \
    qtbase5-dev \
    libqt5svg5-dev \
    swig \
    libxcb-randr0-dev \
    libxcb-xfixes0-dev \
    libx11-xcb-dev \
    libxcb1-dev \
    libgrpc++-dev \
    libgrpc++1 \
    libgrpc-dev \
    libgrpc6 \
    protobuf-compiler-grpc

# Fix 'error while loading shared libraries: libQt5Core.so.5'
# https://github.com/dnschneid/crouton/wiki/Fix-error-while-loading-shared-libraries:-libQt5Core.so.5
RUN strip --remove-section=.note.ABI-tag /usr/lib/x86_64-linux-gnu/libQt5Core.so.5

# Compile obs-studio
RUN git clone --recursive https://github.com/obsproject/obs-studio.git && \
    cd obs-studio && \
    mkdir build && cd build  && \
    cmake -DENABLE_UI=false -DENABLE_SCRIPTING=false -DUNIX_STRUCTURE=1 -DCMAKE_INSTALL_PREFIX="${HOME}/obs-studio-portable" ..  && \
    make -j1 && make install

# Compile obs-headless
COPY proto shows src compile.sh config.sh config.txt run_server.sh ./
RUN sh compile.sh

ENTRYPOINT ./run_server.sh

