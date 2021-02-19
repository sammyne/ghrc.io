FROM ubuntu:20.04

LABEL MAINTAINER="sammyne"

# no question/dialog is asked during apt install
ENV DEBIAN_FRONTEND=noninteractive  

WORKDIR /home/sammyne

#RUN sed -i 's/archive.ubuntu.com/mirrors.ustc.edu.cn/g' /etc/apt/sources.list &&\
#  sed -i 's/security.ubuntu.com/mirrors.ustc.edu.cn/g' /etc/apt/sources.list

RUN apt update                              &&\
  apt install -y curl unzip                 &&\
  curl -L -o protoc.zip https://github.com/protocolbuffers/protobuf/releases/download/v3.15.0/protoc-3.15.0-linux-x86_64.zip &&\
  unzip -d protoc protoc.zip                &&\
  cp protoc/bin/protoc /usr/local/bin/      &&\
  cp -r protoc/include/google /usr/include/ &&\
  rm -rf protoc*                            &&\
  protoc --version

RUN curl -L https://github.com/protocolbuffers/protobuf-go/releases/download/v1.25.0/protoc-gen-go.v1.25.0.linux.amd64.tar.gz |\
  tar -zxv -C /usr/local/bin/
