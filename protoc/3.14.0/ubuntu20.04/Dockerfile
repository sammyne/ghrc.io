FROM ubuntu:20.04

LABEL MAINTAINER="sammyne"

# no question/dialog is asked during apt install
ENV DEBIAN_FRONTEND=noninteractive  

WORKDIR /home/sammyne

RUN sed -i 's/archive.ubuntu.com/mirrors.ustc.edu.cn/g' /etc/apt/sources.list &&\
  sed -i 's/security.ubuntu.com/mirrors.ustc.edu.cn/g' /etc/apt/sources.list

RUN apt update  && apt install -y                 \
  autoconf automake libtool curl make g++ unzip   &&\
  curl -L https://github.com/protocolbuffers/protobuf/releases/download/v3.14.0/protobuf-cpp-3.14.0.tar.gz |\
  tar -zxv                                          &&\
  cd protobuf-3.14.0                                &&\
  ./configure                                       &&\
#  make -j && make check && make install && ldconfig &&\
  make && make install && ldconfig                  &&\
  cd -                                              &&\
  rm -rf protobuf-3.14.0                            &&\
  apt clean                                         &&\
  rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

#RUN curl -L https://github.com/protocolbuffers/protobuf/releases/download/v3.14.0/protobuf-cpp-3.14.0.tar.gz |\
#  tar -zxv                                          &&\

RUN curl -L https://github.com/protocolbuffers/protobuf-go/releases/download/v1.25.0/protoc-gen-go.v1.25.0.linux.amd64.tar.gz |\
  tar -zxv -C /usr/local/bin/
