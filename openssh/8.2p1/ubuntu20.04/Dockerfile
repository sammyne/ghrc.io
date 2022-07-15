FROM ubuntu:20.04

RUN apt update && apt install -y openssh-server && mkdir /run/sshd

WORKDIR /hack

ADD entrypoint.sh .

EXPOSE 22

ENTRYPOINT ["/hack/entrypoint.sh"]
