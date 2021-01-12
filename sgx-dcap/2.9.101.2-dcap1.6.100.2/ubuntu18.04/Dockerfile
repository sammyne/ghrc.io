FROM ubuntu:18.04

# the matching driver version is v1.33
ENV DCAP_VERSION=1.6.100.2            \
  DEBIAN_FRONTEND=noninteractive      \
  SDK_VERSION=2.9.101.2

#RUN UBUNTU_CODENAME=$(cat /etc/os-release | grep UBUNTU_CODENAME | awk -F"=" '{print $2}') &&\
#  echo > /etc/apt/sources.list                                      &&\     
#  # change apt source list
#  echo "deb http://mirrors.tuna.tsinghua.edu.cn/ubuntu/ ${UBUNTU_CODENAME} main restricted universe multiverse" >> /etc/apt/sources.list          &&\
#  echo "deb http://mirrors.tuna.tsinghua.edu.cn/ubuntu/ ${UBUNTU_CODENAME}-updates main restricted universe multiverse" >> /etc/apt/sources.list  &&\
#  echo "deb http://mirrors.tuna.tsinghua.edu.cn/ubuntu/ ${UBUNTU_CODENAME}-security main restricted universe multiverse" >> /etc/apt/sources.list                    

# dependencies tree can be checked out as 
# apt-cache depends -i      \
#   libsgx-urts             \
#   libsgx-qe3-logic        \
#   libsgx-pce-logic        \
#   libsgx-dcap-ql          \
#   libsgx-dcap-default-qpl

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
  apt clean                                                           &&\
  rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*   
