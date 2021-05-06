FROM sammyne/rsgx-dcap:2.9.101.2-dcap1.6.100.2-rs20200407-ubuntu18.04

RUN export GO_VERSION=1.16                                            &&\
  cd /root                                                            &&\
  wget "https://dl.google.com/go/go${GO_VERSION}.linux-amd64.tar.gz"  &&\
  tar -C /usr/local -xzf go${GO_VERSION}.linux-amd64.tar.gz           &&\
  rm -f go${GO_VERSION}.linux-amd64.tar.gz                            &&\
  ln -sf /usr/local/go/bin/* /usr/bin
