FROM busybox:1.36.1 AS repo

WORKDIR /output

RUN wget -O - https://github.com/bojand/ghz/releases/download/v0.117.0/ghz-linux-x86_64.tar.gz | tar -zxv


FROM ubuntu:20.04

RUN apt update                                  &&\
  apt install -y sysstat                        &&\
  apt clean                                     &&\
  rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ENV PATH=/opt/ghz:$PATH

COPY --from=repo /output /opt/ghz

ENTRYPOINT ["ghz"]
