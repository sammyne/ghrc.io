# @ref: https://gramine.readthedocs.io/en/v1.3/devel/building.html
FROM sammyne/sgx-dcap:2.17.100.3-dcap1.14.100.3-ubuntu20.04

# meson>=0.60 has breaking changes on shared_library
# see
#  - https://gramine.readthedocs.io/en/v1.3.1/devel/building.html#common-dependencies
#  - https://gramine.readthedocs.io/en/v1.3.1/devel/building.html#required-packages
RUN apt update                                                  &&\ 
  apt install -y build-essential                                \
    autoconf bison gawk nasm ninja-build python3 python3-click  \
    python3-jinja2 python3-pyelftools wget python3-pip          &&\
  python3 -m pip install 'meson==0.63.2' 'toml>=0.10'           &&\
  apt install -y libcurl4-openssl-dev                           \
    libprotobuf-c-dev protobuf-c-compiler protobuf-compiler     \
    python3-cryptography python3-pip python3-protobuf           &&\
  apt install -y git pkg-config

WORKDIR /github.com/intel/SGXDataCenterAttestationPrimitives

# reason for libsgx-dcap-quote-verify-dev sees
#  https://gramine.readthedocs.io/en/v1.3/devel/building.html#install-dependencies-for-dcap
RUN git clone -v https://github.com/intel/SGXDataCenterAttestationPrimitives .              &&\
  git checkout DCAP_1.14                                                                    &&\
  UBUNTU_CODENAME="$(cat /etc/os-release | grep UBUNTU_CODENAME | awk -F"=" '{print $2}')"  &&\
  dcapTag=${DCAP_VERSION}-${UBUNTU_CODENAME}1                                               &&\
  apt install -y libsgx-dcap-quote-verify-dev

WORKDIR /github.com/sammyne/gramine

# the ninja command can be replaced since meson>=0.55.0
#  sed -i 's/ftp.gnu.org/mirrors.tuna.tsinghua.edu.cn/g' subprojects/glibc-2.34-1.wrap           &&\
RUN git clone -v https://github.com/sammyne/gramine .                                                     &&\
  git checkout 1.3.1-fix-local-attn                                                                       &&\
  meson setup build/ --buildtype=release -Ddirect=enabled -Dsgx=enabled -Dsgx_driver=dcap1.10             \
    -Ddcap=enabled -Dmusl=disabled                                                                        \
    -Dsgx_driver_include_path="/github.com/intel/SGXDataCenterAttestationPrimitives/driver/linux/include" &&\
  meson compile -C build                                                                                  &&\
  meson install -C build
