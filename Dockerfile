FROM ubuntu:20.04 as build
ARG OBS_VERSION=23.2.1

# Install git grpc
RUN apt-get update && \
    apt-get install -y \
    git \
    libgrpc++-dev \
    libgrpc++1 \
    libgrpc-dev \
    libgrpc6 \
    protobuf-compiler-grpc

# Compile obs-studio
RUN git clone --recursive https://github.com/obsproject/obs-studio.git && \
    git checkout $OBS_VERSION && \
    cd obs-studio && \
    mkdir build && cd build  && \
    cmake -DUNIX_STRUCTURE=0 -DCMAKE_INSTALL_PREFIX="${HOME}/obs-studio-portable" ..  && \
    make -j4 && make install

