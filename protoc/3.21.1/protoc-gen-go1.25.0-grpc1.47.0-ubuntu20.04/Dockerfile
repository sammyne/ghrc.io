FROM golang:1.18.3-bullseye AS pluginGrpc

ENV VERSION v1.47.0

RUN git clone -b $VERSION https://github.com/grpc/grpc-go.git  &&\
  cd grpc-go/cmd/protoc-gen-go-grpc                           &&\
  go install . 

RUN mkdir /output && cp $(go env GOPATH)/bin/protoc-gen-go-grpc /output/

FROM ubuntu:20.04 as builder

# no question/dialog is asked during apt install
ENV DEBIAN_FRONTEND=noninteractive

WORKDIR /home/sammyne

ENV PROTOC_VERSION 21.1
ENV PROTOBUF_GO_VERSION v1.28.0

RUN apt update                              &&\
  apt install -y curl unzip                 &&\
  curl -L -o protoc.zip https://github.com/protocolbuffers/protobuf/releases/download/v$PROTOC_VERSION/protoc-$PROTOC_VERSION-linux-x86_64.zip &&\
  unzip protoc.zip                          &&\
  ./bin/protoc --version

RUN curl -L https://github.com/protocolbuffers/protobuf-go/releases/download/$PROTOBUF_GO_VERSION/protoc-gen-go.$PROTOBUF_GO_VERSION.linux.amd64.tar.gz |\
  tar -zxv -C bin/

FROM ubuntu:20.04

LABEL MAINTAINER="sammyne"

WORKDIR /home/sammyne

COPY --from=builder /home/sammyne/bin/* /usr/local/bin/
COPY --from=builder /home/sammyne/include/google /usr/include/
COPY --from=pluginGrpc /output/* /usr/local/bin/

ENTRYPOINT ["protoc"]
