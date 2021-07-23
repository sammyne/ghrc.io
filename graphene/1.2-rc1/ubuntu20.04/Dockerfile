FROM sammyne/sgx-dcap:2.14.100.2-dcap1.11.100.2-ubuntu20.04 AS base

#RUN sed -i 's/archive.ubuntu.com/mirrors.ustc.edu.cn/g' /etc/apt/sources.list &&\
#  sed -i 's/security.ubuntu.com/mirrors.ustc.edu.cn/g' /etc/apt/sources.list

RUN apt update && apt install -y libprotobuf-c-dev

FROM base AS builder

RUN apt install -y \
  build-essential bison python3 libcurl4-openssl-dev  \
  python3-protobuf protobuf-c-compiler python3-pip    \
  python3-click python3-jinja2 libunwind8           &&\
  python3 -m pip install toml>=0.10

RUN apt install -y git autoconf gawk meson wget

WORKDIR /root/SGXDataCenterAttestationPrimitives

RUN git clone -v https://hub.fastgit.org/intel/SGXDataCenterAttestationPrimitives . &&\
  git checkout DCAP_1.11

WORKDIR /root/graphene

RUN git clone -v https://hub.fastgit.org/oscarlab/graphene.git .            &&\
  git checkout v1.2-rc1                                                     &&\
  openssl genrsa -3 -out Pal/src/host/Linux-SGX/signer/enclave-key.pem 3072

RUN make -j3 DEBUG=1 SGX=1 ISGX_DRIVER_PATH="/root/SGXDataCenterAttestationPrimitives/driver/linux" &&\
  meson build -Dsgx=enabled     &&\
  ninja -C build                &&\
  ninja -C build install
