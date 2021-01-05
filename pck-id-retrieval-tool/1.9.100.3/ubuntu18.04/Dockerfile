FROM sammyne/sgx-dcap:2.12.100.3-dcap1.9.100.3-slim-ubuntu18.04

# no deb for v1.9
# @dev why commenting out 'PCCS_URL', see
#   https://github.com/intel/SGXDataCenterAttestationPrimitives/issues/147#issuecomment-741082089
RUN export PKG=PCKIDRetrievalTool_v1.9.100.3                                    &&\
  curl -O https://download.01.org/intel-sgx/sgx-dcap/1.9/linux/tools/SGXCertRetrievalTool/ubuntu18.04-server/${PKG}.tar.gz  &&\
  tar -zxvf ${PKG}.tar.gz -C /opt/intel/                                        &&\
  rm ${PKG}.tar.gz                                                              &&\
  ln -sf /opt/intel/${PKG}/PCKIDRetrievalTool /usr/local/bin/PCKIDRetrievalTool &&\
  #  PCKIDRetrievalTool -?   &&\
  sed -i 's/PCCS_URL/#PCCS_URL/g' /opt/intel/${PKG}/network_setting.conf

CMD PCKIDRetrievalTool -f out.csv && cat out.csv
