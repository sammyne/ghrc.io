FROM sammyne/scala:2.12.15-openjdk8-ubuntu20.04

RUN RUST_VERSION=1.60.0                                               &&\
  apt update                                                          &&\
  apt install -y --reinstall systemd                                  &&\
  apt install -y curl                                                 &&\
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs |           \
    sh -s -- -y --default-toolchain ${RUST_VERSION}                   &&\
  . $HOME/.cargo/env                                                  &&\
  rustup component add rust-src rls rust-analysis                     &&\
  echo 'source $HOME/.cargo/env' >> ~/.bashrc                         &&\
  rm -rf /root/.cargo/registry                                        &&\
  rm -rf /root/.cargo/git
