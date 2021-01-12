FROM sammyne/sgx-dcap:2.12.100.3-dcap1.9.100.3-ubuntu18.04

RUN UBUNTU_CODENAME="$(cat /etc/os-release | grep UBUNTU_CODENAME | awk -F"=" '{print $2}')" &&\
  sdkTag=${SDK_VERSION}-${UBUNTU_CODENAME}1                                   &&\
  dcapTag=${DCAP_VERSION}-${UBUNTU_CODENAME}1                                 &&\
  apt update                                                                  &&\
  apt -y install wget build-essential gcc-8 python lsof                       &&\        
  wget -O sgx_linux_x64_sdk_${SDK_VERSION}.bin https://download.01.org/intel-sgx/sgx-dcap/1.9/linux/distro/ubuntu18.04-server/sgx_linux_x64_sdk_${SDK_VERSION}.bin     &&\
  chmod a+x sgx_linux_x64_sdk_${SDK_VERSION}.bin                              &&\
  echo -e "no\n/opt/intel" | ./sgx_linux_x64_sdk_${SDK_VERSION}.bin           &&\
  rm -f sgx_linux_x64_sdk_${SDK_VERSION}.bin                                  &&\
  mkdir /etc/init                                                             &&\
  apt install -y --allow-downgrades      \         
  libsgx-enclave-common-dev=$sdkTag      \
  libsgx-epid-dev=$sdkTag                \
  libsgx-launch-dev=$sdkTag              \
  libsgx-quote-ex-dev=$sdkTag            \
  libsgx-dcap-ql-dev=$dcapTag            \
  libsgx-dcap-default-qpl-dev=$dcapTag &&\
  echo "source /opt/intel/sgxsdk/environment" >> /root/.bashrc    &&\
  apt clean                                                       &&\
  rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*   
