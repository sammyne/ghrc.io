FROM busybox:1.35.0 AS repo

WORKDIR /output

RUN wget -O - https://github.com/Tencent/TencentKona-8/releases/download/8.0.12-GA/TencentKona8.0.12.b1_jdk_linux-x86_64_8u352.tar.gz | \
    tar -zxv &&\
    mv TencentKona-* TencentKona

FROM ubuntu:20.04

ENV JAVA_HOME=/opt/TencentKona

ENV PATH=$PATH:$JAVA_HOME/bin

COPY --from=repo /output/TencentKona $JAVA_HOME
