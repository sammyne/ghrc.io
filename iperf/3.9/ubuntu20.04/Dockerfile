FROM ubuntu:20.04

RUN apt update && apt install -y iperf3 && apt clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ENTRYPOINT ["iperf3"]
