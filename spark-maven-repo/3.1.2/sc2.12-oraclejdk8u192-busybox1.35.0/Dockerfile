FROM sammyne/scala:2.12.15-oraclejdk8u192-ubuntu20.04 AS builder

ENV DEBIAN_FRONTEND=noninteractive

WORKDIR /spark

RUN apt update                                                      &&\
    apt install -y git maven                                        &&\
    git clone -b v3.1.2 --depth 1 https://github.com/apache/spark .

RUN mvn -T 1.0C dependency:go-offline -B -Pkubernetes

RUN ./dev/make-distribution.sh -Pkubernetes

FROM busybox:1.35.0

WORKDIR /m2

COPY --from=builder /root/.m2 .
