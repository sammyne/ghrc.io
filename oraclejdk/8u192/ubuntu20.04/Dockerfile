FROM busybox:1.35.0 AS repo

ENV JDK_VERSION=8u192

WORKDIR /output

# '-O -' means output to stdout
RUN wget -O - https://repo.huaweicloud.com/java/jdk/${JDK_VERSION}-b12/jdk-${JDK_VERSION}-linux-x64.tar.gz | \
    tar -zxv &&\
    mv jdk* jdk

FROM ubuntu:20.04

ENV JAVA_HOME=/opt/jdk

ENV PATH=$PATH:$JAVA_HOME/bin

COPY --from=repo /output/jdk $JAVA_HOME
