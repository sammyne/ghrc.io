FROM ubuntu:20.04 as builder
# @see https://optee.readthedocs.io/en/latest/building/prerequisites.html#prerequisites

ENV DEBIAN_FRONTEND=noninteractive

#RUN sed -i 's/archive.ubuntu.com/mirrors.ustc.edu.cn/g' /etc/apt/sources.list &&\
#  sed -i 's/security.ubuntu.com/mirrors.ustc.edu.cn/g' /etc/apt/sources.list

RUN dpkg --add-architecture i386                                            &&\
  apt update                                                                &&\
  # ubuntu 20.04 has dropped python-serial
  apt install -y android-tools-adb android-tools-fastboot autoconf            \
  automake bc bison build-essential ccache cscope curl device-tree-compiler   \
  expect flex ftp-upload gdisk iasl libattr1-dev libcap-dev                   \
  libfdt-dev libftdi-dev libglib2.0-dev libhidapi-dev libncurses5-dev         \
  libpixman-1-dev libssl-dev libtool make                                     \
  mtools netcat python-crypto python3-crypto python-pyelftools                \
  python3-pycryptodome python3-pyelftools python3-serial                      \
  rsync unzip uuid-dev xdg-utils xterm xz-utils zlib1g-dev                    \
  wget cpio                                                                 &&\
  apt install -y git cmake                                                  &&\
  ln -sf /usr/bin/python3 /usr/bin/python
