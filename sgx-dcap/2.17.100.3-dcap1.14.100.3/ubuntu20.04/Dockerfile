FROM ubuntu:20.04

#RUN sed -i 's/archive.ubuntu.com/mirrors.tencent.com/g' /etc/apt/sources.list &&\
#  sed -i 's/security.ubuntu.com/mirrors.tencent.com/g' /etc/apt/sources.list

# @ref Intel® SGX Software Installation Guide For Linux* OS - 06/09/2021
# the matching driver version is v1.41
ENV DCAP_VERSION=1.14.100.3           \
  DEBIAN_FRONTEND=noninteractive      \
  SDK_VERSION=2.17.100.3                

# dependencies tree can be checked out as 
# apt-cache depends -i      \
#   libsgx-urts             \
#   libsgx-qe3-logic        \
#   libsgx-pce-logic        \
#   libsgx-dcap-ql          \
#   libsgx-dcap-default-qpl

# install for Intel SGX Application User
RUN UBUNTU_CODENAME=$(cat /etc/os-release | grep UBUNTU_CODENAME | awk -F"=" '{print $2}') &&\
  sdkTag=${SDK_VERSION}-${UBUNTU_CODENAME}1                           &&\
  dcapTag=${DCAP_VERSION}-${UBUNTU_CODENAME}1                         &&\
  apt update                                                          &&\
  apt install -y curl gnupg2                                          &&\
  curl -fsSL \
  https://download.01.org/intel-sgx/sgx_repo/ubuntu/intel-sgx-deb.key | \
  apt-key add -                                                       &&\
  echo "deb [arch=amd64] https://download.01.org/intel-sgx/sgx_repo/ubuntu ${UBUNTU_CODENAME} main" | tee /etc/apt/sources.list.d/intel-sgx.list &&\
  apt update                                                          &&\
  apt install -y --allow-downgrades                                     \
  # listed based on dependencies topological order
  ## urts
  libsgx-ae-le=$sdkTag                \
  sgx-aesm-service=$sdkTag            \
  libsgx-aesm-launch-plugin=$sdkTag   \
  libsgx-launch=$sdkTag               \
  libsgx-enclave-common=$sdkTag       \
  libsgx-urts=$sdkTag                 \
  # dcap-ql
  libsgx-ae-pce=$sdkTag     \
  libsgx-ae-qe3=$dcapTag    \
  libsgx-ae-qve=$dcapTag    \
  libsgx-qe3-logic=$dcapTag \
  libsgx-pce-logic=$dcapTag \
  libsgx-dcap-ql=$dcapTag   \
  # qpl
  libsgx-dcap-default-qpl=$dcapTag      \
  # uae-service
  #  libsgx-aesm-quote-ex-plugin=$sdkTag   \
  #  libsgx-aesm-epid-plugin=$sdkTag       \
  libsgx-epid=$sdkTag                   \
  libsgx-quote-ex=$sdkTag               \
  libsgx-uae-service=$sdkTag          &&\
  # aesm service need this dir to create socket
  mkdir /var/run/aesmd                                                &&\
  cd /usr/lib/x86_64-linux-gnu/                                       &&\
  ln -s libsgx_dcap_quoteverify.so.1 libsgx_dcap_quoteverify.so       &&\
  apt clean                                                           &&\
  rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*   
