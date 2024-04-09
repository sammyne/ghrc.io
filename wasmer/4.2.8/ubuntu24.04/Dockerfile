# ref: https://docs.wasmer.io/install

FROM busybox:1.36.1 AS repo

WORKDIR /output

ARG VERSION=4.2.8

RUN wget -O wasmer.tgz https://github.com/wasmerio/wasmer/releases/download/v$VERSION/wasmer-linux-amd64.tar.gz

RUN mkdir wasmer && tar -C wasmer -zxvf wasmer.tgz


FROM ubuntu:24.04

ENV WASMER_DIR=/opt/wasmer              \
  WASMER_CACHE_DIR=/root/.wasmer/cache  \
  PATH=/opt/wasmer/bin:$PATH

COPY --from=repo /output/wasmer /opt/wasmer 

ENTRYPOINT ["wasmer"]
