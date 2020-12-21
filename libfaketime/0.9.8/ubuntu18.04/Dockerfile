FROM ubuntu:18.04 as builder

#RUN echo > /etc/apt/sources.list &&\
#  echo "deb http://mirrors.tuna.tsinghua.edu.cn/ubuntu/ bionic main restricted universe multiverse" >> /etc/apt/sources.list              &&\
#  echo "deb http://mirrors.tuna.tsinghua.edu.cn/ubuntu/ bionic-updates main restricted universe multiverse" >> /etc/apt/sources.list  &&\
#  echo "deb http://mirrors.tuna.tsinghua.edu.cn/ubuntu/ bionic-security main restricted universe multiverse" >> /etc/apt/sources.list   &&\
#  apt update

ENV VERSION v0.9.8
WORKDIR /libfaketime

RUN apt install -y --no-install-recommends build-essential git ca-certificates  &&\
  git clone --depth 1 -b ${VERSION} https://github.com/wolfcw/libfaketime .     &&\
  make

# Library is in
# - /libfaketime/libfaketimeMT.so.1
# - /libfaketime/libfaketime.so.1

FROM ubuntu:18.04

COPY --from=builder /libfaketime/libfaketime.so.1 /lib/faketime.so

ENV LD_PRELOAD=/lib/faketime.so \
  FAKETIME="-15d"               \
  DONT_FAKE_MONOTONIC=1

RUN date

# Build the final image
FROM scratch

COPY --from=builder /libfaketime/libfaketimeMT.so.1 /libfaketime.so
