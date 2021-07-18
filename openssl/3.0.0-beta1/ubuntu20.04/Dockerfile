FROM ubuntu:20.04 AS builder

#RUN sed -i 's/archive.ubuntu.com/mirrors.ustc.edu.cn/g' /etc/apt/sources.list &&\
#  sed -i 's/security.ubuntu.com/mirrors.ustc.edu.cn/g' /etc/apt/sources.list

RUN apt update &&\
  apt install -y git build-essential

WORKDIR /openssl

RUN git clone -b openssl-3.0.0-beta1 https://github.com/openssl/openssl.git .

ENV opensslDir=/usr/local/openssl

RUN ./config --prefix=$opensslDir --openssldir=$opensslDir/lib/ssl &&\
  make -j       &&\
  make install

FROM ubuntu:20.04

ENV LD_LIBRARY_PATH="/usr/local/openssl/lib" \
  PATH="/usr/local/openssl/bin:$PATH"

COPY --from=builder /usr/local/openssl /usr/local/openssl
