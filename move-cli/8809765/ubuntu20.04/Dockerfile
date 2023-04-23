FROM rust:1.69.0-bullseye AS builder

ENV REV=8809765 

RUN cargo install --git https://github.com/diem/diem --rev $REV move-cli

WORKDIR /output

RUN mv ${CARGO_HOME}/bin/move move-cli


FROM ubuntu:20.04

COPY --from=builder /output/move-cli /bin/
