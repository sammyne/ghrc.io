# https://grpc.io/docs/languages/cpp/quickstart/#build-and-install-grpc-and-protocol-buffers

FROM ubuntu:20.04

RUN sed -i 's/archive.ubuntu.com/mirrors.tencent.com/g' /etc/apt/sources.list &&\
  sed -i 's/security.ubuntu.com/mirrors.tencent.com/g' /etc/apt/sources.list

ENV DEBIAN_FRONTEND=noninteractive \
  GRPC_VERSION=v1.48.0

RUN apt update && apt install -y git cmake build-essential autoconf libtool pkg-config 

WORKDIR /github.com/grpc/grpc

RUN git clone --recurse-submodules -b $GRPC_VERSION --depth 1 --shallow-submodules https://github.com/grpc/grpc .

RUN cmake -B build -DgRPC_INSTALL=ON  \
    -DgRPC_BUILD_TESTS=OFF            \
    -DCMAKE_INSTALL_PREFIX=/grpc      &&\
  cmake --build build                 &&\
  cmake --install build               &&\
  rm -rf build
