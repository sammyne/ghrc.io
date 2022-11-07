FROM sammyne/scala:2.12.15-oraclejdk8u192-ubuntu20.04 AS builder

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && apt install -y git maven

WORKDIR /spark

RUN git clone -b v3.1.2 --depth 1 https://github.com/apache/spark . &&\
  mvn -T 1.0C dependency:go-offline -B -Pkubernetes                 &&\
  ./dev/make-distribution.sh -Pkubernetes
