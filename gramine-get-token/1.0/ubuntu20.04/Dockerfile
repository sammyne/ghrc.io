FROM sammyne/gramine:1.0-ubuntu20.04 AS builder

FROM python:3.10-slim-bullseye AS output

COPY --from=builder /usr/local/bin/gramine-sgx-get-token /usr/local/bin/

COPY --from=builder /usr/local/lib/python3.8/dist-packages/graminelibos \
  /usr/local/lib/python3.10/site-packages/graminelibos 

RUN pip install click==8.0.3 jinja2==3.0.2 protobuf==3.19.0 toml==0.10.2 

FROM output

RUN gramine-sgx-get-token --help

FROM output
