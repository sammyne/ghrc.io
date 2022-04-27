# ref: https://gramine.readthedocs.io/en/latest/devel/building.html
FROM sammyne/sgx-dcap:2.14.100.2-dcap1.11.100.2-ubuntu20.04

# meson>=0.60 has breaking changes on shared_library
RUN apt update                                                    &&\
  apt install -y build-essential autoconf bison gawk ninja-build  \
    python3 python3-click python3-jinja2 python3-pip wget         &&\
  python3 -m pip install 'meson>=0.55' 'toml>=0.10'               &&\
  apt install -y libcurl4-openssl-dev libprotobuf-c-dev           \
    protobuf-c-compiler python3-cryptography python3-protobuf     &&\
  apt install -y git pkg-config

WORKDIR /root/SGXDataCenterAttestationPrimitives

RUN git clone -v https://github.com/intel/SGXDataCenterAttestationPrimitives . &&\
  git checkout DCAP_1.11

WORKDIR /root/gramine

# the ninja command can be replaced since meson>=0.55.0
# sed -i "s/ftp.gnu.org/$repo/g" subprojects/*.wrap
RUN git clone -v https://github.com/gramineproject/gramine .                                  &&\
  git checkout 86f0d3f                                                                        &&\
  meson setup build/ --buildtype=release -Ddirect=enabled -Dsgx=enabled -Dsgx_driver=dcap1.10 \
    -Ddcap=enabled                                                                            \
    -Dsgx_driver_include_path="/root/SGXDataCenterAttestationPrimitives/driver/linux/include" &&\
  meson compile -C build                                                                      &&\
  meson install -C build                                                                      &&\
  gramine-sgx-gen-private-key
