FROM alpine:3.17.1 AS repo

WORKDIR /output

RUN apk add git

RUN git clone -b v2.12.2 http://mirrors.ustc.edu.cn/aosp/git-repo.git

RUN cd git-repo chmod u+x repo && cp repo /output/


FROM ubuntu:20.04
# @see https://optee.readthedocs.io/en/latest/building/prerequisites.html#prerequisites

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update &&\
  apt install -y \
  android-tools-adb \
  android-tools-fastboot \
  autoconf \
  automake \
  bc \
  bison \
  build-essential \
  ccache \
  cscope \
  curl \
  device-tree-compiler \
  expect \
  flex \
  ftp-upload \
  gdisk \
  iasl \
  libattr1-dev \
  libcap-dev \
  libfdt-dev \
  libftdi-dev \
  libglib2.0-dev \
  libgmp3-dev \
  libhidapi-dev \
  libmpc-dev \
  libncurses5-dev \
  libpixman-1-dev \
  libssl-dev \
  libtool \
  make \
  mtools \
  netcat \
  ninja-build \
  python3-crypto \
  python3-cryptography \
  python3-pip \
  python3-pyelftools \
  python3-serial \
  rsync \
  unzip \
  uuid-dev \
  xdg-utils \
  xterm \
  xz-utils \
  zlib1g-dev

# WHY slirp-dev sees
#  - https://wiki.qemu.org/ChangeLog/7.2#Removal_of_the_%22slirp%22_submodule_(affects_%22-netdev_user%22)
RUN apt install -y wget cpio git cmake vim      &&\
  apt install -y libslirp-dev                   &&\
  ln -sf /usr/bin/python3 /usr/bin/python       &&\
  apt clean                                     &&\
  rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY --from=repo /output/repo /bin/repo

ENV USE_CCACHE=1              \
  CCACHE_DIR=/optee/.ccache   \
  CCACHE_UMASK=002

RUN useradd --shell /bin/bash -u 1000 -o -c "" -m optee &&\
  echo 'optee:optee' | chpasswd                         &&\
  mkdir /optee                                          &&\
  chown -R optee:optee /optee

USER optee

# Configure git so repo won't complain later on
RUN git config --global user.name "optee"           &&\
  git config --global user.email "optee@github.com"

WORKDIR /optee

RUN repo init -b 3.20.0 -u https://github.com/OP-TEE/manifest.git -m qemu_v8.xml && repo sync -j4 -v

WORKDIR /optee/build

# hotfix: enable slirp explicitly for QEMU>=7.2
# ref: https://wiki.qemu.org/ChangeLog/7.2#Removal_of_the_%22slirp%22_submodule_(affects_%22-netdev_user%22)
RUN sed -i "471i QEMU_CONFIGURE_PARAMS_COMMON += --enable-slirp" common.mk  &&\
  make -j4 toolchains                                                       &&\ 
  make -j4
