FROM ubuntu:20.04 AS repo

RUN apt update && apt install -y git

WORKDIR /output

RUN git clone https://github.com/brendangregg/FlameGraph  &&\
  cd FlameGraph                                           &&\
  git checkout d9fcc27                                    &&\
  rm -rf .git


FROM ubuntu:20.04

COPY --from=repo /output/FlameGraph /opt/FlameGraph

ENV PATH=/opt/FlameGraph:$PATH

# perf is needed by /opt/FlameGraph/flamegraph.pl
RUN apt update                                  &&\
  apt install -y bpfcc-tools perl               &&\
  apt clean                                     &&\
  rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
