FROM golang:1.16.6-buster AS pluginGrpc

RUN git clone -b v1.39.0 https://github.com/grpc/grpc-go.git  &&\
  cd grpc-go/cmd/protoc-gen-go-grpc                           &&\
  go install . 

RUN mkdir /output && cp $(go env GOPATH)/bin/protoc-gen-go-grpc /output/

FROM ubuntu:20.04 as builder

# no question/dialog is asked during apt install
ENV DEBIAN_FRONTEND=noninteractive

WORKDIR /home/sammyne

RUN sed -i 's/archive.ubuntu.com/mirrors.ustc.edu.cn/g' /etc/apt/sources.list &&\
  sed -i 's/security.ubuntu.com/mirrors.ustc.edu.cn/g' /etc/apt/sources.list

RUN apt update                              &&\
  apt install -y curl unzip                 &&\
  curl -L -o protoc.zip https://github.com/protocolbuffers/protobuf/releases/download/v3.15.0/protoc-3.15.0-linux-x86_64.zip &&\
  unzip protoc.zip                          &&\
  ./bin/protoc --version

RUN curl -L https://github.com/protocolbuffers/protobuf-go/releases/download/v1.25.0/protoc-gen-go.v1.25.0.linux.amd64.tar.gz |\
  tar -zxv -C bin/

FROM ubuntu:20.04

LABEL MAINTAINER="sammyne"

WORKDIR /home/sammyne

COPY --from=builder /home/sammyne/bin/* /usr/local/bin/
COPY --from=builder /home/sammyne/include/google /usr/include/
COPY --from=pluginGrpc /output/* /usr/local/bin/

ENTRYPOINT ["protoc"]
