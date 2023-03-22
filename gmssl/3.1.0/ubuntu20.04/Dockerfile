FROM alpine:3.16.0 AS repo

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.tencent.com/g' /etc/apk/repositories

RUN apk add git

WORKDIR /output

RUN git clone -b v3.1.0 --depth 1 https://github.com/guanzhi/GmSSL.git .


FROM ubuntu:20.04 AS builder

ENV DEBIAN_FRONTEND=noninteractive

WORKDIR /gmssl

COPY --from=repo /output .

RUN sed -i 's/archive.ubuntu.com/mirrors.tencent.com/g' /etc/apt/sources.list &&\
  sed -i 's/security.ubuntu.com/mirrors.tencent.com/g' /etc/apt/sources.list &&\
  apt update

RUN apt install -y build-essential cmake && apt clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

WORKDIR /gmssl/build

RUN cmake -DCMAKE_INSTALL_PREFIX=/opt/gmssl ..

#RUN ./config --prefix=/opt/gmssl && make -j && make install
RUN make -j && make install


FROM ubuntu:20.04

ENV LD_LIBRARY_PATH=/opt/gmssl/lib:$LD_LIBRARY_PATH

ENV PATH=/opt/gmssl/bin:$PATH

COPY --from=builder /opt/gmssl /opt/gmssl

ENTRYPOINT ["gmssl"]
