FROM sammyne/sgx-dcap:2.12.100.3-dcap1.9.100.3-sim-ubuntu18.04

RUN RUST_VERSION=nightly-2020-10-25                                   &&\
  apt update                                                          &&\
  apt install -y --reinstall systemd                                  &&\
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs |           \
  sh -s -- -y --default-toolchain ${RUST_VERSION}                     &&\
  . $HOME/.cargo/env                                                  &&\
  rustup component add rust-src rls rust-analysis                     &&\
  echo 'source $HOME/.cargo/env' >> ~/.bashrc                         &&\
  rm -rf /root/.cargo/registry                                        &&\
  rm -rf /root/.cargo/git

# dev tools
# vim is for edit git commit message
#
# cmake apt repository is released by kitware since 2019-04-05 as 
#   https://blog.kitware.com/ubuntu-cmake-repository-now-available/ and https://apt.kitware.com/
#
# @dev sgx_unwind depends on autoconf 
# @dev autoconf depends on libtool 
# @dev openssl-sys crate depends on libssl-dev and pkg-config
RUN apt install -y apt-transport-https ca-certificates gnupg software-properties-common &&\
  add-apt-repository ppa:git-core/ppa                                                   &&\
  wget -O - https://apt.kitware.com/keys/kitware-archive-latest.asc 2>/dev/null |         \
  gpg --dearmor - | \
  tee /etc/apt/trusted.gpg.d/kitware.gpg >/dev/null                                     &&\
  apt-add-repository "deb https://apt.kitware.com/ubuntu/ $(lsb_release -cs) main"      &&\
  apt update                                                                            &&\
  apt install -y autoconf cmake expect git libssl-dev libtool pkg-config vim            &&\
  apt clean                                                                             &&\
  rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
