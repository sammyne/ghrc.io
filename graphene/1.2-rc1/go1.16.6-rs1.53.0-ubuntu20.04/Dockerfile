FROM sammyne/graphene:1.2-rc1-ubuntu20.04

#RUN sed -i 's/archive.ubuntu.com/mirrors.ustc.edu.cn/g' /etc/apt/sources.list &&\
#  sed -i 's/security.ubuntu.com/mirrors.ustc.edu.cn/g' /etc/apt/sources.list

RUN RUST_VERSION=1.53.0                                               &&\
  apt update                                                          &&\
  apt install -y --reinstall systemd                                  &&\
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs |           \
  sh -s -- -y --default-toolchain ${RUST_VERSION}                     &&\
  . $HOME/.cargo/env                                                  &&\
  rustup component add rust-src rls rust-analysis                     &&\
  echo 'source $HOME/.cargo/env' >> ~/.bashrc                         &&\
  rm -rf /root/.cargo/registry                                        &&\
  rm -rf /root/.cargo/git

RUN export GO_VERSION=1.16.6                                          &&\
  cd /root                                                            &&\
  wget "https://dl.google.com/go/go${GO_VERSION}.linux-amd64.tar.gz"  &&\
  tar -C /usr/local -xzf go${GO_VERSION}.linux-amd64.tar.gz           &&\
  rm -f go${GO_VERSION}.linux-amd64.tar.gz                            &&\
  ln -sf /usr/local/go/bin/* /usr/bin
