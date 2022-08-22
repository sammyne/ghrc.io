
FROM sammyne/grpc-cc:1.48.0-ubuntu20.04 AS grpc-cc

FROM ubuntu:20.04 as builder

# no question/dialog is asked during apt install
ENV DEBIAN_FRONTEND=noninteractive  

WORKDIR /output

RUN apt update && apt install -y curl unzip

ENV PROTOC_VERSION=21.5

RUN curl -L -o protoc.zip https://github.com/protocolbuffers/protobuf/releases/download/v$PROTOC_VERSION/protoc-$PROTOC_VERSION-linux-x86_64.zip &&\
  unzip protoc.zip                          &&\
  ./bin/protoc --version

COPY --from=grpc-cc /usr/local/bin/grpc_cpp_plugin /output/bin/protoc-gen-grpc

RUN mkdir /output/lib                                   &&\
  cd /usr/lib/x86_64-linux-gnu                          &&\
  cp libstdc++.so.6 libgcc_s.so.1 libdl.so.2 /output/lib

FROM busybox:1.35.0-glibc

COPY --from=builder /output/bin /bin
COPY --from=builder /output/include /usr/include
COPY --from=builder /output/lib /lib

ENTRYPOINT ["protoc"]
