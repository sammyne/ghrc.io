FROM ubuntu:20.04

# ref: https://computingforgeeks.com/how-to-install-java-11-on-ubuntu-linux/
# ref: https://jdk.java.net/java-se-ri/11
RUN apt update                                                    &&\
  apt install -y curl                                             &&\
  curl -fL https://github.com/coursier/launchers/raw/master/cs-x86_64-pc-linux.gz | \
    gzip -d > /usr/bin/cs                                         &&\
  chmod u+x /usr/bin/cs                                           &&\
  echo '' >> ~/.bashrc                                            &&\
  echo 'PATH=$PATH:/root/.local/share/coursier/bin' >> ~/.bashrc  &&\
  curl -L https://download.java.net/openjdk/jdk11/ri/openjdk-11+28_linux-x64_bin.tar.gz | \
  tar -zxv -C /usr/local                                  &&\
  echo "" >> ~/.bashrc                                    &&\
  echo "# openjdk" >> ~/.bashrc                           &&\
  echo 'export JAVA_HOME=/usr/local/jdk-11' >> ~/.bashrc  &&\
  echo 'export PATH=$PATH:$JAVA_HOME/bin' >> ~/.bashrc    &&\
  cs setup --apps scala:3.1.1,scalac:3.1.1,sbt,sbtn,ammonite,scalafmt
