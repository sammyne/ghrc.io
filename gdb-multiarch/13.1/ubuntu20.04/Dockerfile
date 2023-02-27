FROM ubuntu:20.04 AS builder

ENV DEBIAN_FRONTEND=noninteractive

RUN sed -i 's/archive.ubuntu.com/mirrors.tencent.com/g' /etc/apt/sources.list &&\
  sed -i 's/security.ubuntu.com/mirrors.tencent.com/g' /etc/apt/sources.list

RUN apt update &&\
  apt install -y python3 && ln -sf /usr/bin/python3 /usr/bin/python                                           &&\
  apt install -y curl build-essential libexpat1-dev file libncurses-dev libgmp-dev libmpfr-dev lzma pkg-config 

WORKDIR /project

RUN curl -LO https://mirrors.ustc.edu.cn/gnu/gdb/gdb-13.1.tar.xz

RUN tar -Jxvf gdb-13.1.tar.xz

WORKDIR /project/gdb-13.1

# ref: https://sourceware.org/gdb/wiki/BuildingCrossGDBandGDBserver
# ref: https://sources.debian.org/src/gdb/12.1-4/debian/rules/#L164
# ref: https://sourceware.org/gdb/onlinedocs/gdb/Requirements.html
RUN ./configure --enable-targets=aarch64-linux-gnu --prefix=/output

RUN make -j 16 && make install


FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive

RUN sed -i 's/archive.ubuntu.com/mirrors.tencent.com/g' /etc/apt/sources.list &&\
  sed -i 's/security.ubuntu.com/mirrors.tencent.com/g' /etc/apt/sources.list

RUN apt update &&\
  apt install -y python3 && ln -sf /usr/bin/python3 /usr/bin/python       &&\
  apt install -y libexpat1-dev libncurses-dev libgmp-dev libmpfr-dev lzma &&\
  apt clean                                                               &&\
  rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY --from=builder /output /opt/gdb-multiarch
