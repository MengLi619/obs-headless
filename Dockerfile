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

# Compile obs-studio
RUN git clone --recursive https://github.com/obsproject/obs-studio.git && \
    cd obs-studio && \
    git checkout $OBS_VERSION && \
    mkdir build && cd build  && \
    cmake -DENABLE_UI=false -DENABLE_SCRIPTING=false -DUNIX_STRUCTURE=0 -DCMAKE_INSTALL_PREFIX="${HOME}/obs-studio-portable" ..  && \
    make -j4 && make install

