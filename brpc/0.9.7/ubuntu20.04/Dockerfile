FROM ubuntu:20.04

LABEL MAINTAINER="sammyne"

# no question/dialog is asked during apt install
ENV DEBIAN_FRONTEND=noninteractive  

WORKDIR /home/sammyne

#RUN sed -i 's/archive.ubuntu.com/mirrors.ustc.edu.cn/g' /etc/apt/sources.list &&\
#  sed -i 's/security.ubuntu.com/mirrors.ustc.edu.cn/g' /etc/apt/sources.list

RUN apt update  && apt install -y                 \
  git g++ make libssl-dev libgflags-dev cmake     \
  libprotobuf-dev libprotoc-dev protobuf-compiler \
  libleveldb-dev                                  &&\
  apt clean                                       &&\
  rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

#RUN git clone -b 0.9.7 https://github.com/apache/incubator-brpc.git brpc  &&\
#  cd brpc                                                                 &&\
#  cmake -B build && cmake --build build -j                                &&\
#  cd example/echo_c++
