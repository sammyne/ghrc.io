FROM sammyne/sgx-dcap:2.12.100.3-dcap1.9.100.3-slim-ubuntu18.04

RUN UBUNTU_CODENAME1="$(cat /etc/os-release | grep UBUNTU_CODENAME | awk -F"=" '{print $2}')1" &&\
  apt update                                                                  &&\
  apt -y install wget build-essential gcc-8 python lsof                       &&\        
  wget -O sgx_linux_x64_sdk_${SDK_VERSION}.bin https://download.01.org/intel-sgx/sgx-dcap/1.6/linux/distro/ubuntuServer18.04/sgx_linux_x64_sdk_${SDK_VERSION}.bin     &&\
  chmod a+x sgx_linux_x64_sdk_${SDK_VERSION}.bin                              &&\
  echo -e "no\n/opt/intel" | ./sgx_linux_x64_sdk_${SDK_VERSION}.bin           &&\
  rm -f sgx_linux_x64_sdk_${SDK_VERSION}.bin                                  &&\
  mkdir /etc/init                                                             &&\
  apt install -y --allow-downgrades                                 \         
  libsgx-aesm-launch-plugin=${SDK_VERSION}-${UBUNTU_CODENAME1}      \
  libsgx-enclave-common=${SDK_VERSION}-${UBUNTU_CODENAME1}          \
  libsgx-enclave-common-dev=${SDK_VERSION}-${UBUNTU_CODENAME1}      \
  libsgx-epid=${SDK_VERSION}-${UBUNTU_CODENAME1}                    \
  libsgx-epid-dev=${SDK_VERSION}-${UBUNTU_CODENAME1}                \
  libsgx-launch=${SDK_VERSION}-${UBUNTU_CODENAME1}                  \
  libsgx-launch-dev=${SDK_VERSION}-${UBUNTU_CODENAME1}              \
  libsgx-quote-ex=${SDK_VERSION}-${UBUNTU_CODENAME1}                \
  libsgx-quote-ex-dev=${SDK_VERSION}-${UBUNTU_CODENAME1}            \
  libsgx-uae-service=${SDK_VERSION}-${UBUNTU_CODENAME1}             \
  libsgx-dcap-ql-dev=${DCAP_VERSION}-${UBUNTU_CODENAME1}            \
  libsgx-dcap-default-qpl-dev=${DCAP_VERSION}-${UBUNTU_CODENAME1} &&\
  echo "source /opt/intel/sgxsdk/environment" >> /root/.bashrc    &&\
  apt clean                                                       &&\
  rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*   
