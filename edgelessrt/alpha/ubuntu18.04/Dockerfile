# @see https://github.com/edgelesssys/edgelessrt/blob/master/Dockerfile

FROM sammyne/sgx-dcap:2.12.100.3-dcap1.9.100.3-sim-ubuntu18.04 as builder

# @see https://github.com/openenclave/openenclave/blob/master/docs/GettingStartedDocs/install_oe_sdk-Ubuntu_18.04.md

# @see edgelesssys/edgelessrt/scripts/ansible/roles/linux/openenclave/vars/ubuntu/main.yml."apt_packages"
RUN apt update                                                                        &&\
  apt install -y software-properties-common                                           &&\
  echo "deb http://apt.llvm.org/bionic/ llvm-toolchain-bionic-7 main" |\
  tee /etc/apt/sources.list.d/llvm-toolchain-bionic-7.list &&\
  wget -qO - https://apt.llvm.org/llvm-snapshot.gpg.key | apt-key add -               &&\
  echo "deb [arch=amd64] https://packages.microsoft.com/ubuntu/18.04/prod bionic main" |\
  tee /etc/apt/sources.list.d/msprod.list &&\
  wget -qO - https://packages.microsoft.com/keys/microsoft.asc | apt-key add -        &&\
  wget -qO - https://apt.kitware.com/keys/kitware-archive-latest.asc | apt-key add -  &&\
  apt-add-repository 'deb https://apt.kitware.com/ubuntu/ bionic main'                &&\
  add-apt-repository ppa:git-core/ppa                                                 &&\
  apt update                                                                          &&\
  apt install -y        \
  curl                  \
  clang-format-7        \
  make                  \
  ninja-build           \
  shellcheck            \
  gcc-8                 \
  g++-8                 \
  gdb                   \
  libssl-dev            \
  openssl               \
  pkg-config            \
  apt-transport-https   \
  autoconf              \
  doxygen               \
  graphviz              \
  libexpat1-dev         \
  libtool               \
  subversion            \
  libcurl4-openssl-dev  \
  libx11-dev            \
  libncurses5-dev       \
  clang-8               \
  clang-format-8        \
  cmake                 \
  git                 &&\
  apt clean           &&\
  rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# validator
FROM alpine/git:v2.30.1 AS gitter 

WORKDIR /edgelessrt

RUN git clone https://github.com/edgelesssys/edgelessrt .

RUN git submodule update --init 3rdparty/openenclave/openenclave 3rdparty/go

WORKDIR /edgelessrt/3rdparty/openenclave/openenclave

RUN git submodule update --init \
  tools/oeedger8r-cpp           \
  3rdparty/mbedtls/mbedtls      \
  3rdparty/musl/musl            \
  3rdparty/musl/libc-test 

FROM builder AS installer

WORKDIR /edgelessrt

COPY --from=gitter /edgelessrt .

RUN cmake -GNinja -DCMAKE_BUILD_TYPE=RelWithDebInfo -B build && ninja -C build install

FROM builder AS validator

WORKDIR /edgelessrt

ENV PKG_CONFIG_PATH=${PKG_CONFIG_PATH}:/opt/edgelessrt/share/pkgconfig  \
  CMAKE_PREFIX_PATH=/opt/edgelessrt/lib/openenclave/cmake               \
  PATH=${PATH}:/opt/edgelessrt/bin/:/opt/edgelessrt/go/bin/

COPY --from=gitter /edgelessrt/samples/go .
COPY --from=installer /opt/edgelessrt /opt/edgelessrt

RUN cmake -B build && cmake --build build

RUN cd build && OE_SIMULATION=1 erthost enclave.signed

# released
FROM builder

ENV PKG_CONFIG_PATH=${PKG_CONFIG_PATH}:/opt/edgelessrt/share/pkgconfig \
  CMAKE_PREFIX_PATH=/opt/edgelessrt/lib/openenclave/cmake \
  PATH=${PATH}:/opt/edgelessrt/bin/:/opt/edgelessrt/go/bin/

COPY --from=installer /opt/edgelessrt /opt/edgelessrt
