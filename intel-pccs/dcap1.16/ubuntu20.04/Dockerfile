# ref: https://github.com/intel/SGXDataCenterAttestationPrimitives/blob/DCAP_1.16/QuoteGeneration/pccs/container/Dockerfile

FROM alpine:3.17.1 as repo

RUN apk add openssl git

WORKDIR /output/pki

RUN openssl genrsa -out private.pem 2048                                      &&\
  openssl req -new -key private.pem -out csr.pem -subj '/C=TX'                &&\
  openssl x509 -req -days 365 -in csr.pem -signkey private.pem  -out file.crt

WORKDIR /output/code

RUN git clone -b DCAP_1.16 --depth=1 https://github.com/intel/SGXDataCenterAttestationPrimitives .


FROM ubuntu:20.04 AS pckLib

RUN sed -i 's/archive.ubuntu.com/mirrors.tencent.com/g' /etc/apt/sources.list &&\
  sed -i 's/security.ubuntu.com/mirrors.tencent.com/g' /etc/apt/sources.list

RUN apt update                            &&\
  apt install -y --no-install-recommends  \
    build-essential                       \
    ca-certificates                       \
    sqlite3                               \
    zip                                   &&\
  apt clean                               &&\
  rm -rf /var/lib/apt/lists/*

WORKDIR /project

COPY --from=repo /output/code .

WORKDIR /project/tools/PCKCertSelection

RUN make -j

RUN mkdir /output && cp out/libPCKCertSelection.so /output/


FROM node:16.20.0-bullseye AS pccs

ENV DEBIAN_FRONTEND=noninteractive

WORKDIR /output

COPY --from=repo /output/code/QuoteGeneration/pccs .

# fix two bugs
#  1. unnecessary requirement of tcb for PCK certs
#  2. case-sensitive string comparison failed TCB searching
RUN sed -i "199s/'tcb', //" services/pccs_schemas.js                              &&\
  sed -i "156s/fmspc/fmspc.toLowerCase()/g" services/platformCollateralService.js

RUN npm config set registry https://registry.npm.taobao.org --global  &&\
  npm config set disturl https://npm.taobao.org/dist --global         &&\
  npm install                                                         &&\
  npm rebuild


FROM ubuntu:20.04

COPY --from=pccs /usr/local/bin/node /usr/bin/

WORKDIR /opt/pccs

COPY --from=repo /output/pki ssl_key
COPY --from=pckLib /output/libPCKCertSelection.so lib/
COPY --from=pccs /output .

ENTRYPOINT ["/usr/bin/node", "pccs_server.js"]