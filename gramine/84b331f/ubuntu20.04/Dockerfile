# @ref: https://gramine.readthedocs.io/en/latest/quickstart.html#quick-start-with-sgx-support
FROM sammyne/sgx-dcap:2.14.100.2-dcap1.11.100.2-ubuntu20.04 AS base

#ENV repo=mirrors.tuna.tsinghua.edu.cn
#RUN sed -i "s/archive.ubuntu.com/$repo/g" /etc/apt/sources.list &&\
#  sed -i "s/security.ubuntu.com/$repo/g" /etc/apt/sources.list

RUN apt update && apt install -y libprotobuf-c-dev

FROM base AS builder

# meson>=0.60 has breaking changes on shared_library
RUN apt install -y build-essential                                        \
    autoconf bison gawk libcurl4-openssl-dev libprotobuf-c-dev            \
    ninja-build protobuf-c-compiler python3 python3-click python3-jinja2  \
    python3-pip python3-protobuf wget                                   &&\
    python3 -m pip install 'meson==0.59.3' 'toml>=0.10'                 &&\
    apt install -y git pkg-config

WORKDIR /root/SGXDataCenterAttestationPrimitives

RUN git clone -v https://github.com/intel/SGXDataCenterAttestationPrimitives . &&\
  git checkout DCAP_1.11

WORKDIR /root/gramine

# the ninja command can be replaced since meson>=0.55.0
#  sed -i 's/ftp.gnu.org/mirrors.tuna.tsinghua.edu.cn/g' subprojects/glibc-2.34.wrap           &&\
RUN git clone -v https://github.com/gramineproject/gramine .                                  &&\
  git checkout 84b331f                                                                        &&\
  meson setup build/ --buildtype=release -Ddirect=enabled -Dsgx=enabled -Dsgx_driver=dcap1.10 \
    -Ddcap=enabled                                                                            \
    -Dsgx_driver_include_path="/root/SGXDataCenterAttestationPrimitives/driver/linux/include" &&\
  meson compile -C build                                                                      &&\
  meson install -C build                                                                      &&\
  openssl genrsa -3 -out Pal/src/host/Linux-SGX/signer/enclave-key.pem 3072
