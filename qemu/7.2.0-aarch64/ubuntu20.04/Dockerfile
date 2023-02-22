FROM busybox:1.36.0 AS cache

WORKDIR /output

ENV VERSION=7.2.0

RUN wget --no-check-certificate https://download.qemu.org/qemu-$VERSION.tar.xz

RUN tar -Jxvf qemu-$VERSION.tar.xz && mv qemu-$VERSION qemu

FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive

RUN sed -i 's/archive.ubuntu.com/mirrors.tencent.com/g' /etc/apt/sources.list &&\
  sed -i 's/security.ubuntu.com/mirrors.tencent.com/g' /etc/apt/sources.list

# ref: https://wiki.qemu.org/Hosts/Linux
RUN apt update                                                                                                &&\
  apt install --no-install-recommends -y git libglib2.0-dev libfdt-dev libpixman-1-dev zlib1g-dev ninja-build   \
    build-essential                                                                                           &&\
  apt clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

WORKDIR /qemu

COPY --from=cache /output/qemu .

RUN ./configure --target-list=aarch64-softmmu && make -j && make install && make clean

ENTRYPOINT ["qemu-system-aarch64"]
