FROM busybox:1.35.0 AS repo

WORKDIR /output

RUN wget -O - https://github.com/Tencent/TencentKona-8/releases/download/8.0.11-GA/TencentKona8.0.11.b2_jdk_linux-x86_64_8u345.tar.gz | \
    tar -zxv &&\
    mv TencentKona-* TencentKona

FROM ubuntu:20.04

ENV JAVA_HOME=/opt/TencentKona

ENV PATH=$PATH:$JAVA_HOME/bin

COPY --from=repo /output/TencentKona $JAVA_HOME
