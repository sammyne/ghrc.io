# ref: https://github.com/openenclave/openenclave/blob/master/docs/GettingStartedDocs/install_oe_sdk-Ubuntu_20.04.md
FROM sammyne/sgx-dcap:2.17.100.3-dcap1.14.100.3-ubuntu20.04

ENV OE_VERSION=0.18.2
#RUN echo "deb http://apt.llvm.org/focal/ llvm-toolchain-focal-10 main" | sudo tee /etc/apt/sources.list.d/llvm-toolchain-focal-10.list &&\
#  wget -qO - https://apt.llvm.org/llvm-snapshot.gpg.key | sudo apt-key add -

RUN apt update                                                                              &&\
  apt install -y wget                                                                       &&\
  echo "deb [arch=amd64] https://packages.microsoft.com/ubuntu/20.04/prod focal main" | \
    tee /etc/apt/sources.list.d/msprod.list                                                 &&\
  wget -qO - https://packages.microsoft.com/keys/microsoft.asc | apt-key add -              &&\
  apt update                                                                                &&\
  apt -y install clang-10 libssl-dev gdb libsgx-enclave-common libsgx-quote-ex libprotobuf17 \
    libsgx-dcap-ql libsgx-dcap-ql-dev az-dcap-client open-enclave=$OE_VERSION cmake

