FROM busybox:1.35.0 AS repo

WORKDIR /output

RUN wget -O - https://github.com/Tencent/TencentKona-11/releases/download/kona11.0.16.1/TencentKona-11.0.16.b2-jdk_linux-x86_64.tar.gz | \
    tar -zxv &&\
    mv TencentKona-* TencentKona

FROM ubuntu:20.04

ENV JAVA_HOME=/opt/TencentKona

ENV PATH=$PATH:$JAVA_HOME/bin

COPY --from=repo /output/TencentKona $JAVA_HOME
