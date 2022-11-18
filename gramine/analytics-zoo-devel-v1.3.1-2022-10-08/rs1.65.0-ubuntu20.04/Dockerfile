FROM sammyne/gramine:analytics-zoo-devel-v1.3.1-2022-10-08-ubuntu20.04

ENV PATH=/root/.cargo/bin:$PATH

RUN RUST_VERSION=1.65.0                                               &&\
  apt update                                                          &&\
  apt install -y --reinstall systemd                                  &&\
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs |           \
  sh -s -- -y --default-toolchain ${RUST_VERSION}                     &&\
  rustup component add rust-src rls rust-analysis                     &&\
  rm -rf /root/.cargo/registry                                        &&\
  rm -rf /root/.cargo/git                                             &&\
  rm -rf /var/lib/apt/lists/*                                         