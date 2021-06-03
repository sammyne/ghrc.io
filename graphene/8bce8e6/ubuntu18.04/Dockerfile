FROM sammyne/sgx-dcap:2.12.100.3-dcap1.9.100.3-ubuntu18.04 AS base

#RUN sed -i 's/archive.ubuntu.com/mirrors.ustc.edu.cn/g' /etc/apt/sources.list &&\
#  sed -i 's/security.ubuntu.com/mirrors.ustc.edu.cn/g' /etc/apt/sources.list

RUN apt update && apt install -y \
  libprotobuf-c-dev

FROM base AS builder

RUN apt install -y \
  build-essential bison python3 libcurl4-openssl-dev  \
  python3-protobuf protobuf-c-compiler python3-pip    \
  python3-click python3-jinja2 libunwind8           &&\
  python3 -m pip install toml>=0.10

RUN apt install -y git autoconf gawk meson wget

WORKDIR /root/SGXDataCenterAttestationPrimitives

RUN git clone -v https://hub.fastgit.org/intel/SGXDataCenterAttestationPrimitives . &&\
  git checkout fcb226f

WORKDIR /root/graphene

RUN git clone -v https://hub.fastgit.org/oscarlab/graphene.git .            &&\
  git checkout 8bce8e6                                                      &&\
  openssl genrsa -3 -out Pal/src/host/Linux-SGX/signer/enclave-key.pem 3072

RUN make -j3 DEBUG=1 SGX=1 ISGX_DRIVER_PATH="/root/SGXDataCenterAttestationPrimitives/driver/linux" &&\
  meson build -Dsgx=enabled     &&\
  ninja -C build                &&\
  ninja -C build install
