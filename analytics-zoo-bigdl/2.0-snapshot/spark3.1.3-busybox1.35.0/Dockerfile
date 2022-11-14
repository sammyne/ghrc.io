FROM alpine:3.16.3 AS builder

RUN apk add wget unzip bash

ENV BIGDL_VERSION=2.2.0-SNAPSHOT

ENV SPARK_VERSION=3.1.3

ENV BIGDL_HOME /output

RUN wget \
  https://raw.githubusercontent.com/intel-analytics/analytics-zoo/bigdl-2.0/docker/hyperzoo/download-bigdl.sh &&\
  bash download-bigdl.sh                                                                                      &&\
  rm bigdl*.zip

FROM busybox:1.35.0

WORKDIR /output

COPY --from=builder /output .
