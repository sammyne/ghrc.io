FROM golang:1.20.7-bullseye AS pprof

RUN go install github.com/google/pprof@2ba5b33

WORKDIR /output

RUN cp `which pprof` ./


FROM ubuntu:20.04

# ref: https://www.graphviz.org/download/#linux
RUN apt update                                  &&\
  apt install -y graphviz                       &&\
  apt clean                                     &&\
  rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY --from=pprof /output/* /bin/

ENTRYPOINT ["pprof"]
