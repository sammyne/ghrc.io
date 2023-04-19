FROM busybox:1.35.0 AS repo

WORKDIR /output

ENV VERSION=3.9.1

RUN wget -O - https://dlcdn.apache.org/maven/maven-3/$VERSION/binaries/apache-maven-$VERSION-bin.tar.gz | \
  tar -zxv                                                                                              &&\
  mv apache-maven-* maven


FROM sammyne/scala:2.12.10-konajdk8.0.13-ubuntu20.04 AS builder

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && apt install -y git curl && apt clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ENV PATH=/opt/maven/bin:$PATH

# install maven by apt will overwrite jdk
COPY --from=repo /output/maven /opt/maven

WORKDIR /github.com/apache/spark

RUN git clone -b v3.1.3 --depth 1 https://github.com/apache/spark . &&\
  mvn -T 1.0C dependency:go-offline -B -Pkubernetes                 &&\
  ./dev/make-distribution.sh -Pkubernetes
