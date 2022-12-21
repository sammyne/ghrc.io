FROM busybox:1.35.0 AS repo

WORKDIR /output

RUN wget -O - https://dlcdn.apache.org/maven/maven-3/3.6.3/binaries/apache-maven-3.6.3-bin.tar.gz | \
  tar -zxv                                                                                        &&\
  mv apache-maven-* maven


FROM sammyne/scala:2.12.10-konajdk8.0.12-ubuntu20.04 AS builder

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && apt install -y git curl

ENV PATH=/opt/maven/bin:$PATH

# install maven by apt will overwrite jdk
COPY --from=repo /output/maven /opt/maven

WORKDIR /output

RUN apt update && apt install -y build-essential zip

WORKDIR /protobuf

RUN curl -L https://github.com/protocolbuffers/protobuf/releases/download/v2.5.0/protobuf-2.5.0.tar.bz2 | tar -jxv

RUN cd protobuf-2.5.0 && ./configure && make -j && make install

ENV LD_LIBRARY_PATH=/usr/local/lib

WORKDIR /github.com/analytics-zoo/hadoop

RUN git clone -b branch-3.2.0-ppml --depth 1 https://github.com/analytics-zoo/hadoop.git .

RUN cd hadoop-common-project/hadoop-common                  &&\
  export MAVEN_OPTS="-Xmx2g -XX:ReservedCodeCacheSize=512m" &&\
  mvn -T 16 -DskipTests=true clean package                  &&\
  mv target/hadoop-common-3.2.0.jar /output/


FROM busybox:1.35.0

WORKDIR /output

COPY --from=builder /output .
