FROM alpine:3.12 as builder

#RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.tuna.tsinghua.edu.cn/g' /etc/apk/repositories &&\
#  apk update

ENV VERSION v0.9.8

WORKDIR /libfaketime

RUN apk add build-base git                                                  &&\
  git clone --depth 1 -b ${VERSION} https://github.com/wolfcw/libfaketime . &&\
  make

# Library is in
# - /libfaketime/src/libfaketimeMT.so.1
# - /libfaketime/src/libfaketime.so.1

# Verify in Alpline
FROM alpine:3.12

COPY --from=builder /libfaketime/src/libfaketimeMT.so.1 /lib/libfaketime.so

ENV LD_PRELOAD=/lib/faketime.so \
  FAKETIME="-15d"               \
  DONT_FAKE_MONOTONIC=1

RUN date

# Build the final image
FROM scratch

COPY --from=builder /libfaketime/src/libfaketimeMT.so.1 /libfaketime.so