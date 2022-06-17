FROM alpine:3.15.4 AS repo

WORKDIR /output

RUN apk add curl

ENV VERSION=0.11.1
ENV PROTOC_VERSION=21.1

RUN curl -LO https://github.com/scalapb/ScalaPB/releases/download/v$VERSION/scalapbc-$VERSION.zip

RUN unzip scalapbc-$VERSION.zip && mv scalapbc-$VERSION scalapbc

RUN curl -LO https://github.com/protocolbuffers/protobuf/releases/download/v$PROTOC_VERSION/protoc-$PROTOC_VERSION-linux-x86_64.zip

RUN mkdir protoc                                          &&\
  unzip protoc-$PROTOC_VERSION-linux-x86_64.zip -d protoc &&\
  cd protoc/bin                                           &&\
  mv protoc protoc-linux-x86_64-$PROTOC_VERSION

FROM ubuntu:20.04 AS base

ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk
ENV PATH=$JAVA_HOME/bin:/opt/scalapbc/bin:$PATH

#RUN sed -i 's/archive.ubuntu.com/mirrors.tencent.com/g' /etc/apt/sources.list &&\
#  sed -i 's/security.ubuntu.com/mirrors.tencent.com/g' /etc/apt/sources.list

RUN apt update && apt install -y openjdk-8-jdk

FROM base AS rc

COPY --from=repo /output/scalapbc /opt/scalapbc 
COPY --from=repo /output/protoc/bin/* /root/.cache/protocbridge/v1/

RUN scalapbc -v3.21.1 --version

FROM base

COPY --from=rc /opt /opt
COPY --from=rc /root/.cache /root/.cache 
COPY --from=repo /output/protoc/include/* /usr/include/

# v21.1 isn't ok
ENTRYPOINT ["scalapbc", "-v3.21.1"]
