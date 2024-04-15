FROM busybox:1.36.1 as protoc

ENV PROTOC_VERSION 26.1

WORKDIR /output

RUN wget -O protoc.zip https://github.com/protocolbuffers/protobuf/releases/download/v$PROTOC_VERSION/protoc-$PROTOC_VERSION-linux-x86_64.zip &&\
  unzip protoc.zip                          &&\
  ./bin/protoc --version

RUN rm -rf protoc.zip

FROM busybox:1.36.1 as protoc-gen-go

WORKDIR /output

ENV PROTOBUF_GO_VERSION v1.33.0

RUN wget -O - https://github.com/protocolbuffers/protobuf-go/releases/download/$PROTOBUF_GO_VERSION/protoc-gen-go.$PROTOBUF_GO_VERSION.linux.amd64.tar.gz |\
  tar -zxv 


FROM golang:1.22.1-bookworm AS protoc-gen-go-grpc

ENV VERSION v1.63.2

RUN git clone -b $VERSION https://github.com/grpc/grpc-go.git  &&\
  cd grpc-go/cmd/protoc-gen-go-grpc                           &&\
  go install . 

RUN mkdir /output && cp $(go env GOPATH)/bin/protoc-gen-go-grpc /output/


FROM ubuntu:24.04 AS rc

WORKDIR /output

COPY --from=protoc /output .

COPY --from=protoc-gen-go /output/* ./bin/

COPY --from=protoc-gen-go-grpc /output/* ./bin/


FROM ubuntu:24.04

LABEL MAINTAINER="sammyne"

WORKDIR /opt/protoc

ENV PATH=/opt/protoc/bin:$PATH

COPY --from=rc /output .

ENTRYPOINT ["protoc"]
