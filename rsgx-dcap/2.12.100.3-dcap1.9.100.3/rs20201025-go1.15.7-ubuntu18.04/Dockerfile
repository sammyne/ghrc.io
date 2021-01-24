FROM sammyne/rsgx-dcap:2.12.100.3-dcap1.9.100.3-rs20201025-ubuntu18.04

RUN export GO_VERSION=1.15.7                                          &&\
  cd /root                                                            &&\
  wget "https://dl.google.com/go/go${GO_VERSION}.linux-amd64.tar.gz"  &&\
  tar -C /usr/local -xzf go${GO_VERSION}.linux-amd64.tar.gz           &&\
  rm -f go${GO_VERSION}.linux-amd64.tar.gz                            &&\
  ln -sf /usr/local/go/bin/* /usr/bin
