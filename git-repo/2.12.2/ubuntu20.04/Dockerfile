FROM ubuntu:20.04

WORKDIR /home/sammyne

# available for repo can be checked from /usr/bin/repo script
ENV DEBIAN_FRONTEND=noninteractive \
  REPO_URL='https://gerrit-googlesource.lug.ustc.edu.cn/git-repo' \
  REPO_REV=v2.12.2

#RUN sed -i 's/archive.ubuntu.com/mirrors.ustc.edu.cn/g' /etc/apt/sources.list &&\
#  sed -i 's/security.ubuntu.com/mirrors.ustc.edu.cn/g' /etc/apt/sources.list

RUN apt update                                                      &&\
  apt install -y git python3                                        &&\
  ln -sf /usr/bin/python3 /usr/bin/python                           &&\
  git clone -b v2.12.2 http://mirrors.ustc.edu.cn/aosp/git-repo.git &&\
  cp git-repo/repo /usr/bin/                                        &&\
  repo --version                                                    &&\
  rm -rf git-repo

CMD repo
