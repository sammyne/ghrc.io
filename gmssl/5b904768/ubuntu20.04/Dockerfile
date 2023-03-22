FROM alpine:3.16.0 AS repo

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.tencent.com/g' /etc/apk/repositories

RUN apk add git

WORKDIR /output

RUN git clone https://github.com/guanzhi/GmSSL.git . && git checkout 5b904768


FROM ubuntu:20.04 AS builder

WORKDIR /gmssl

COPY --from=repo /output .

RUN sed -i 's/archive.ubuntu.com/mirrors.tencent.com/g' /etc/apt/sources.list &&\
  sed -i 's/security.ubuntu.com/mirrors.tencent.com/g' /etc/apt/sources.list &&\
  apt update

RUN apt install -y build-essential && apt clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN sed -i "s|qw/glob|qw/:glob|g" Configure && sed -i "s|qw/glob|qw/:glob|g" test/build.info

RUN ./config --prefix=/opt/gmssl && make -j && make install


FROM ubuntu:20.04

ENV LD_LIBRARY_PATH=/opt/gmssl/lib:$LD_LIBRARY_PATH

ENV PATH=/opt/gmssl/bin:$PATH

COPY --from=builder /opt/gmssl /opt/gmssl

ENTRYPOINT ["gmssl"]
