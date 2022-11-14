FROM busybox:1.35.0 AS repo

WORKDIR /output

RUN wget -O - https://dlcdn.apache.org/maven/maven-3/3.6.3/binaries/apache-maven-3.6.3-bin.tar.gz | \
  tar -zxv                                                                                        &&\      
  mv apache-maven-* maven

FROM sammyne/oraclejdk:8u192-ubuntu20.04 AS builder

ENV PATH=/opt/maven/bin:$PATH

# install maven by apt will overwrite jdk
COPY --from=repo /output/maven /opt/maven

WORKDIR /output

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && apt install -y git

WORKDIR /github.com/analytics-zoo/hive

RUN git clone -b branch-2.3.7-ppml --depth 1 https://github.com/analytics-zoo/hive.git .

RUN cd ql && mvn -T 2.0C -X -DskipTests=true clean package && mv target/hive-exec-2.3.7-core.jar /output/

FROM busybox:1.35.0

WORKDIR /output

COPY --from=builder /output .
