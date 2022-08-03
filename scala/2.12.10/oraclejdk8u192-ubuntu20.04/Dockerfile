FROM busybox:1.35.0 AS repo

WORKDIR /output 

RUN wget -O - https://github.com/coursier/launchers/raw/master/cs-x86_64-pc-linux.gz  | \
  gzip -d > cs                                                                        &&\
  chmod u+x cs

FROM sammyne/oraclejdk:8u192-ubuntu20.04

ENV PATH=$PATH:/root/.local/share/coursier/bin

COPY --from=repo /output/cs /usr/bin/cs

RUN cs setup --apps scala:2.12.10,scalac:2.12.10,sbt:1.7.1,sbtn,ammonite,scalafmt:3.5.8
