# @ref: https://gramine.readthedocs.io/en/v1.4/devel/building.html
FROM sammyne/sgx-dcap:2.17.100.3-dcap1.14.100.3-ubuntu20.04

# meson>=0.60 has breaking changes on shared_library
# see
#  - https://gramine.readthedocs.io/en/v1.4/devel/building.html#common-dependencies
#  - https://gramine.readthedocs.io/en/v1.4/devel/building.html#required-packages
RUN apt update                                                                              &&\ 
  apt install -y build-essential                                                            \
    autoconf bison gawk nasm ninja-build python3 python3-click                              \
    python3-jinja2 python3-pip python3-pyelftools wget                                      &&\
  python3 -m pip install 'meson==0.63.2' 'tomli>=1.1.0' 'tomli-w>=0.4.0'                    &&\
  apt install -y libcurl4-openssl-dev                                                       \
    libprotobuf-c-dev protobuf-c-compiler protobuf-compiler                                 \
    python3-cryptography python3-pip python3-protobuf                                       &&\
  apt install -y git pkg-config                                                             &&\
  UBUNTU_CODENAME="$(cat /etc/os-release | grep UBUNTU_CODENAME | awk -F"=" '{print $2}')"  &&\
  apt install -y libsgx-dcap-quote-verify-dev=${DCAP_VERSION}-${UBUNTU_CODENAME}1           &&\
  apt clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN mkdir -p /github.com/torvalds/linux/blob/v5.15/arch/x86/include/uapi/asm                   &&\
  cd /github.com/torvalds/linux/blob/v5.15/arch/x86/include/uapi/asm                           &&\
  wget https://raw.githubusercontent.com/torvalds/linux/v5.15/arch/x86/include/uapi/asm/sgx.h

WORKDIR /github.com/gramineproject/gramine

# the ninja command can be replaced since meson>=0.55.0
RUN git clone -b v1.4 --depth 1 -v https://github.com/gramineproject/gramine .                  &&\
  meson setup build/ --buildtype=release -Ddirect=enabled -Dsgx=enabled -Dsgx_driver=upstream   \
    -Ddcap=enabled -Dmusl=disabled                                                              \
    -Dsgx_driver_include_path="/github.com/torvalds/linux/blob/v5.15/arch/x86/include/uapi"      &&\
  meson compile -C build                                                                        &&\
  meson install -C build
