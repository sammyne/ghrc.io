FROM busybox:1.35.0 AS repo

WORKDIR /output

RUN wget -O - https://github.com/AdoptOpenJDK/openjdk8-binaries/releases/download/jdk8u292-b10/OpenJDK8U-jdk_x64_linux_hotspot_8u292b10.tar.gz | \
    tar -zxv &&\
    mv jdk8* AdoptOpenJDK

FROM ubuntu:20.04

ENV JAVA_HOME=/opt/AdoptOpenJDK

ENV PATH=$PATH:$JAVA_HOME/bin

COPY --from=repo /output/AdoptOpenJDK $JAVA_HOME
