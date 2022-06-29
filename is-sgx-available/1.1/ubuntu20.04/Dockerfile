FROM sammyne/gramine:1.1-ubuntu20.04 AS builder

FROM ubuntu:20.04

COPY --from=builder /usr/local/bin/is-sgx-available /bin/

ENTRYPOINT ["/bin/is-sgx-available"]
