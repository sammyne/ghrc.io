# ref: https://hub.docker.com/layers/library/openjdk/8-jdk-bullseye/images/sha256-3af2ac94130765b73fc8f1b42ffc04f77996ed8210c297fcfa28ca880ff0a217?context=explore
FROM busybox:1.35.0 AS repo

WORKDIR /output

RUN wget -O - https://github.com/AdoptOpenJDK/openjdk8-upstream-binaries/releases/download/jdk8u342-b07/OpenJDK8U-jdk_x64_linux_8u342b07.tar.gz | \
    tar -zxv &&\
    mv openjdk-* openjdk

FROM ubuntu:20.04

ENV JAVA_HOME=/opt/openjdk

ENV PATH=$PATH:$JAVA_HOME/bin

COPY --from=repo /output/openjdk $JAVA_HOME
