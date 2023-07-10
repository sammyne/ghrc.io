FROM busybox:1.36.0-glibc as builder

ENV VERSION v1.18.20

WORKDIR /output

RUN wget https://storage.googleapis.com/kubernetes-release/release/${VERSION}/bin/linux/amd64/kubectl

RUN chmod +x kubectl && cp kubectl /bin/ 

RUN kubectl version --client


FROM ubuntu:20.04

# https://stackoverflow.com/a/50607259
RUN sed -i 's/archive.ubuntu.com/mirrors.tencent.com/g' /etc/apt/sources.list   &&\
  sed -i 's/security.ubuntu.com/mirrors.tencent.com/g' /etc/apt/sources.list    &&\
  apt update                                                                    &&\
  apt install -y bash-completion                                                &&\
  apt clean                                                                     &&\
  rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*                                 &&\
  echo 'if [ -f /etc/bash_completion ] && ! shopt -oq posix; then' >> ~/.bashrc &&\
  echo '  . /etc/bash_completion' >> ~/.bashrc                                  &&\
  echo 'fi' >> ~/.bashrc

COPY --from=builder /output/kubectl /usr/bin/kubectl

RUN mkdir /etc/bash_completion.d && kubectl completion bash | tee /etc/bash_completion.d/kubectl

ENTRYPOINT ["kubectl"]
