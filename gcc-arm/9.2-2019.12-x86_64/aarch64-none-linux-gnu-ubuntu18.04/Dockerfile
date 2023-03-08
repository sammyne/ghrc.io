FROM alpine:3.17.1 AS repo

WORKDIR /output

RUN apk add curl

ARG VERSION=9.2-2019.12
ARG REV=61c3be5d51754db69030b565aae9f766
ARG REVISION=61c3be5d-5175-4db6-9030-b565aae9f766
ARG HASH=43A89163112C6A1E6DBBE3B14CC393143722BD0E

# ref: https://developer.arm.com/downloads/-/arm-gnu-toolchain-downloads
RUN curl -k -L -o gcc-arm-$VERSION-x86_64-aarch64-none-linux-gnu.tar.xz \
  "https://developer.arm.com/-/media/Files/downloads/gnu-a/$VERSION/binrel/gcc-arm-$VERSION-x86_64-aarch64-none-linux-gnu.tar.xz?revision=$REVISION&rev=$REV&hash=$HASH"

RUN tar -Jxvf gcc-arm-$VERSION-x86_64-aarch64-none-linux-gnu.tar.xz &&\
  mv gcc-arm-$VERSION-x86_64-aarch64-none-linux-gnu gcc-arm


FROM ubuntu:18.04

ENV PATH=$PATH:/opt/gcc-arm/bin

COPY --from=repo /output/gcc-arm /opt/gcc-arm
