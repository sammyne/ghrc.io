FROM sammyne/scala:2.12.15-openjdk8-ubuntu20.04

#RUN sed -i 's/archive.ubuntu.com/mirrors.tencent.com/g' /etc/apt/sources.list &&\
#  sed -i 's/security.ubuntu.com/mirrors.tencent.com/g' /etc/apt/sources.list

RUN apt update && apt install -y openssh-server && mkdir /run/sshd

WORKDIR /hack

ADD entrypoint.sh .

EXPOSE 22

ENTRYPOINT ["/hack/entrypoint.sh"]
