FROM ubuntu:20.04

#RUN sed -i 's/archive.ubuntu.com/mirrors.tencent.com/g' /etc/apt/sources.list &&\
#  sed -i 's/security.ubuntu.com/mirrors.tencent.com/g' /etc/apt/sources.list &&\
#  apt update

# ref: https://computingforgeeks.com/how-to-install-java-11-on-ubuntu-linux/
# ref: https://jdk.java.net/java-se-ri/11
# ref: https://linuxize.com/post/install-java-on-ubuntu-20-04/
RUN apt update                                                            &&\
  apt install -y openjdk-8-jdk                                            &&\
  echo "" >> ~/.profile                                                    &&\
  echo "# openjdk" >> ~/.profile                                           &&\
  echo 'export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64' >> ~/.profile  &&\
  apt install -y curl                                                     &&\
  curl -fL https://github.com/coursier/launchers/raw/master/cs-x86_64-pc-linux.gz | \
    gzip -d > /usr/bin/cs                                                 &&\
  chmod u+x /usr/bin/cs                                                   &&\
  echo '' >> ~/.profile                                                   &&\
  echo 'export PATH=$PATH:/root/.local/share/coursier/bin' >> ~/.profile  &&\
  . ~/.profile                                                            &&\
  cs setup --apps scala:2.12.15,scalac:2.12.15,sbt,sbtn,ammonite,scalafmt
