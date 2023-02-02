FROM busybox:1.35.0 AS repo

WORKDIR /output

ENV URL=https://github.com/Tencent/TencentKona-8/releases/download/8.0.13-GA/TencentKona8.0.13.b1_jre_linux-x86_64_8u362.tar.gz

RUN wget -O - $URL | tar -zxv && mv TencentKona-* TencentKona

FROM ubuntu:20.04

ENV JAVA_HOME=/opt/TencentKona

ENV PATH=$PATH:$JAVA_HOME/bin

COPY --from=repo /output/TencentKona $JAVA_HOME
