FROM busybox:1.35.0 AS repo

WORKDIR /output

RUN wget -O - https://dlcdn.apache.org/maven/maven-3/3.6.3/binaries/apache-maven-3.6.3-bin.tar.gz | \
  tar -zxv                                                                                        &&\
  mv apache-maven-* maven


FROM sammyne/scala:2.12.10-oraclejdk8u192-ubuntu20.04 AS builder

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && apt install -y git curl

ENV PATH=/opt/maven/bin:$PATH

# install maven by apt will overwrite jdk
COPY --from=repo /output/maven /opt/maven

WORKDIR /spark

RUN git clone -b v3.1.2 --depth 1 https://github.com/apache/spark . &&\
  mvn -T 1.0C dependency:go-offline -B -Pkubernetes                 &&\
  ./dev/make-distribution.sh -Pkubernetes
