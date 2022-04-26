FROM ubuntu:20.04

ENV JAVA_HOME=/usr/local/jdk-11
ENV PATH=$PATH:/root/.local/share/coursier/bin:$JAVA_HOME/bin

# ref: https://computingforgeeks.com/how-to-install-java-11-on-ubuntu-linux/
# ref: https://jdk.java.net/java-se-ri/11
RUN apt update                                                            &&\
  apt install -y curl                                                     &&\
  curl -L https://download.java.net/openjdk/jdk11/ri/openjdk-11+28_linux-x64_bin.tar.gz | \
  tar -zxv -C /usr/local                                                  &&\
  curl -fL https://github.com/coursier/launchers/raw/master/cs-x86_64-pc-linux.gz | \
    gzip -d > /usr/bin/cs                                                 &&\
  chmod u+x /usr/bin/cs                                                   &&\
  cs setup --apps scala:3.1.1,scalac:3.1.1,sbt,sbtn,ammonite,scalafmt
