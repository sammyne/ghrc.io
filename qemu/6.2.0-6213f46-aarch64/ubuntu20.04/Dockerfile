FROM alpine:3.17.1 AS cache

RUN apk add git

WORKDIR /output

ENV VERSION=6213f46

RUN git clone https://github.com/0xMirasio/qemu-patch-raspberry4.git qemu

WORKDIR /output/qemu

RUN git checkout $VERSION && git submodule update --init --recursive


FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive

# ref: https://wiki.qemu.org/Hosts/Linux
RUN apt update                                                                                                &&\
  apt install --no-install-recommends -y git libglib2.0-dev libfdt-dev libpixman-1-dev zlib1g-dev ninja-build   \
    build-essential                                                                                           &&\
  apt clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

WORKDIR /qemu

COPY --from=cache /output/qemu .

RUN ./configure --target-list=aarch64-softmmu && make -j && make install && make clean

ENTRYPOINT ["qemu-system-aarch64"]
