FROM sammyne/openjdk:8-ubuntu20.04

ENV PATH=$PATH:/root/.local/share/coursier/bin

# ref: https://computingforgeeks.com/how-to-install-java-11-on-ubuntu-linux/
# ref: https://jdk.java.net/java-se-ri/11
# ref: https://linuxize.com/post/install-java-on-ubuntu-20-04/
# ammonite ref:
#   - https://github.com/com-lihaoyi/Ammonite
#   - https://ammonite.io/
# scalafmt ref: https://github.com/scalameta/scalafmt
RUN apt update                                                                    &&\
  apt install -y curl                                                             &&\
  curl -fL https://github.com/coursier/launchers/raw/master/cs-x86_64-pc-linux.gz | \
    gzip -d > /usr/bin/cs                                                         &&\
  chmod u+x /usr/bin/cs                                                           &&\
  cs setup --apps scala:2.12.15,scalac:2.12.15,sbt:1.7.1,sbtn:1.7.1,ammonite:2.5.4,scalafmt:3.5.8
