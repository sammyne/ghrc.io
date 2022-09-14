# @ref: https://gramine.readthedocs.io/en/v1.2/devel/building.html
FROM sammyne/sgx-dcap:2.17.100.3-dcap1.14.100.3-ubuntu20.04 AS base

#ENV repo=mirrors.tencent.com
#RUN sed -i "s/archive.ubuntu.com/$repo/g" /etc/apt/sources.list &&\
#  sed -i "s/security.ubuntu.com/$repo/g" /etc/apt/sources.list

RUN apt update && apt install -y libprotobuf-c-dev

FROM base AS builder

# meson>=0.60 has breaking changes on shared_library
# nasm, python3-cryptography are added in v1.2
RUN apt install -y build-essential                                        \
    autoconf bison gawk nasm libcurl4-openssl-dev ninja-build             \
    protobuf-c-compiler python3 python3-click python3-cryptography        \
    python3-jinja2 python3-pip python3-protobuf wget                    &&\
    python3 -m pip install 'meson==0.59.3' 'toml>=0.10'                 &&\
    apt install -y git pkg-config

WORKDIR /root/SGXDataCenterAttestationPrimitives

RUN git clone -v https://github.com/intel/SGXDataCenterAttestationPrimitives . &&\
  git checkout DCAP_1.14

WORKDIR /root/gramine

# the ninja command can be replaced since meson>=0.55.0
#  sed -i 's/ftp.gnu.org/mirrors.tuna.tsinghua.edu.cn/g' subprojects/glibc-2.34-1.wrap           &&\
RUN git clone -v https://github.com/gramineproject/gramine .                                  &&\
  git checkout v1.2                                                                           &&\
  meson setup build/ --buildtype=release -Ddirect=enabled -Dsgx=enabled -Dsgx_driver=dcap1.10 \
    -Ddcap=enabled -Dlibgomp=enabled -Dmusl=disabled                                          \
    -Dsgx_driver_include_path="/root/SGXDataCenterAttestationPrimitives/driver/linux/include" &&\
  meson compile -C build                                                                      &&\
  meson install -C build
