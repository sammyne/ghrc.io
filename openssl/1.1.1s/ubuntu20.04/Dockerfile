FROM ubuntu:20.04 AS builder

RUN apt update && apt install -y git build-essential

WORKDIR /openssl

RUN git clone -b OpenSSL_1_1_1s --depth 1 https://github.com/openssl/openssl.git .

RUN ./config --prefix=/opt/openssl

RUN make -j

RUN make install_sw

FROM ubuntu:20.04

ENV LD_LIBRARY_PATH="/opt/openssl/lib" \
  PATH="/opt/openssl/bin:$PATH"

COPY --from=builder /opt/openssl /opt/openssl
