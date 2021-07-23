FROM sammyne/sgx-dcap:2.14.100.2-dcap1.11.100.2-ubuntu20.04

# @dev why commenting out 'PCCS_URL', see
#   https://github.com/intel/SGXDataCenterAttestationPrimitives/issues/147#issuecomment-741082089
RUN UBUNTU_CODENAME=$(cat /etc/os-release | grep UBUNTU_CODENAME | awk -F"=" '{print $2}') &&\
  dcapTag=${DCAP_VERSION}-${UBUNTU_CODENAME}1   &&\
  apt update                                                              &&\
  apt install -y --allow-downgrades                                         \
    libsgx-ra-uefi=$dcapTag                                                 \
    sgx-pck-id-retrieval-tool=$dcapTag                                    &&\
  sed -i 's/PCCS_URL/#PCCS_URL/g' /opt/intel/sgx-pck-id-retrieval-tool/network_setting.conf

CMD PCKIDRetrievalTool -f out.csv && cat out.csv
