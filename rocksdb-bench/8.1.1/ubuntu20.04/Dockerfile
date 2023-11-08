FROM ubuntu:20.04 AS base

ENV DEBIAN_FRONTEND=noninteractive

#RUN sed -i 's/archive.ubuntu.com/mirrors.tencent.com/g' /etc/apt/sources.list &&\
#  sed -i 's/security.ubuntu.com/mirrors.tencent.com/g' /etc/apt/sources.list

RUN apt update                                                                            &&\
  apt install -y libgflags-dev libsnappy-dev zlib1g-dev libbz2-dev liblz4-dev libzstd-dev &&\
  apt clean                                                                               &&\
  rm -rf /var/lib/a pt/lists/* /tmp/* /var/tmp/*


FROM base AS builder

RUN apt update && apt install -y build-essential cmake git

ENV TAG=v8.1.1

WORKDIR /github.com/facebook/rocksdb

RUN git clone -b $TAG --depth 1 https://github.com/facebook/rocksdb .

RUN cmake -B build -DCMAKE_PREFIX_PATH=/output -DWITH_SNAPPY=1 -DWITH_LZ4=1 -DWITH_ZLIB=1 -DWITH_ZSTD=1 \
  -DCMAKE_BUILD_TYPE=Release

RUN cmake --build build --target db_bench

RUN mkdir -p /output/lib /output/bin && cd build &&\
  mv db_bench /output/bin/ &&\
  mv librocksdb.so* /output/lib/


FROM base

ENV PATH=/opt/rocksdb/bin:$PATH    \
  LD_LIBRARY_PATH=/opt/rocksdb/lib

COPY --from=builder /output /opt/rocksdb
