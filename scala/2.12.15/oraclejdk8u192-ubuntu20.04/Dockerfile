FROM ubuntu:20.04

ENV JAVA_HOME=/opt/jdk \
  JDK_VERSION=8u192

ENV PATH=$PATH:/root/.local/share/coursier/bin:$JAVA_HOME/bin

RUN apt update                                                                                          &&\
  apt install -y curl                                                                                   &&\
  curl -L https://repo.huaweicloud.com/java/jdk/${JDK_VERSION}-b12/jdk-${JDK_VERSION}-linux-x64.tar.gz | \
    tar -zxv && mv jdk* /opt/jdk                                                                        &&\
  curl -fL https://github.com/coursier/launchers/raw/master/cs-x86_64-pc-linux.gz | \
    gzip -d > /usr/bin/cs                                                                               &&\
  chmod u+x /usr/bin/cs                                                                                 &&\
  cs setup --apps scala:2.12.15,scalac:2.12.15,sbt,sbtn,ammonite,scalafmt
