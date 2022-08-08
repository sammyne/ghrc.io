# ref: https://jdk.java.net/archive/
FROM busybox:1.35.0 AS repo

WORKDIR /output

RUN wget -O - https://download.java.net/java/GA/jdk11/9/GPL/openjdk-11.0.2_linux-x64_bin.tar.gz | \
    tar -zxv &&\
    mv jdk* jdk

FROM ubuntu:20.04

ENV JAVA_HOME=/opt/jdk

ENV PATH=$PATH:$JAVA_HOME/bin

COPY --from=repo /output/jdk $JAVA_HOME
