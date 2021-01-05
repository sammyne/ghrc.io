FROM sammyne/sgx-dcap:2.9.101.2-dcap1.6.100.2-slim-ubuntu18.04

# no deb for v1.6
# @dev why commenting out 'PCCS_URL', see
#   https://github.com/intel/SGXDataCenterAttestationPrimitives/issues/147#issuecomment-741082089
RUN export PKG=sgx-pck-id-retrieve-tool_1.7.100.2-1_amd64.deb &&\
  curl -O https://download.01.org/intel-sgx/sgx-dcap/1.7/linux/tools/SGXCertRetrievalTool/ubuntu18.04-server/${PKG}  &&\
  dpkg -i ${PKG}          &&\
  rm ${PKG}               &&\
  #  PCKIDRetrievalTool -?   &&\
  sed -i 's/PCCS_URL/#PCCS_URL/g' /opt/intel/sgx-pck-id-retrieve-tool/network_setting.conf

# read output from stderr
CMD PCKIDRetrievalTool -f out.csv && cat out.csv
