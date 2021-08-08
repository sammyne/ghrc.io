FROM ubuntu:20.04 as builder

# no question/dialog is asked during apt install
ENV DEBIAN_FRONTEND=noninteractive  

RUN mkdir -p /output/bin /output/include /output/lib

#RUN sed -i 's/archive.ubuntu.com/mirrors.ustc.edu.cn/g' /etc/apt/sources.list &&\
#  sed -i 's/security.ubuntu.com/mirrors.ustc.edu.cn/g' /etc/apt/sources.list

RUN apt update &&\
  apt install -y build-essential autoconf libtool pkg-config git cmake

WORKDIR /sammyne/grpc

#ADD grpc .

RUN git clone --recurse-submodules -b v1.35.0 https://github.com/grpc/grpc . &&\
  mkdir -p cmake/build                                  &&\
  cd cmake/build                                        &&\
  cmake -DgRPC_INSTALL=ON -DgRPC_BUILD_TESTS=OFF ../..  &&\
  make grpc_cpp_plugin -j4                              &&\
  cp grpc_cpp_plugin /output/bin/protoc-gen-grpc        &&\
  cd /usr/lib/x86_64-linux-gnu                          &&\
  cp libstdc++.so.6 libgcc_s.so.1 /output/lib           &&\
  cp /lib/x86_64-linux-gnu/libdl.so.2 /output/lib

WORKDIR /sammyne

RUN apt update                              &&\
  apt install -y curl unzip                 &&\
  curl -L -o protoc.zip https://github.com/protocolbuffers/protobuf/releases/download/v3.13.0/protoc-3.13.0-linux-x86_64.zip &&\
  unzip protoc.zip                          &&\
  ./bin/protoc --version                    &&\
  cp bin/protoc /output/bin/

RUN curl -L https://github.com/protocolbuffers/protobuf-go/releases/download/v1.25.0/protoc-gen-go.v1.25.0.linux.amd64.tar.gz |\
  tar -zxv -C bin/                      &&\
  cp bin/protoc-gen-go /output/bin/     &&\
  cp -r include/google /output/include

FROM golang:1.16.7-buster AS pluginGoGrpc

RUN git clone -b v1.35.0 https://github.com/grpc/grpc-go.git  &&\
  cd grpc-go/cmd/protoc-gen-go-grpc                           &&\
  go install . 

RUN mkdir /output && cp $(go env GOPATH)/bin/protoc-gen-go-grpc /output/

FROM busybox:1.33.1-glibc

COPY --from=builder /output/bin /bin
COPY --from=builder /output/include /usr/include
COPY --from=builder /output/lib /lib
COPY --from=pluginGoGrpc /output /bin

ENTRYPOINT ["protoc"]
