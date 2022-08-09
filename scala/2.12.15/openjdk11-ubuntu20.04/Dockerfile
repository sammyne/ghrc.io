FROM busybox:1.35.0 AS repo

WORKDIR /output

RUN wget -O - https://github.com/coursier/launchers/raw/master/cs-x86_64-pc-linux.gz | gzip -d > cs

RUN chmod u+x cs

FROM sammyne/openjdk:11.0.2-9-ubuntu20.04

ENV PATH=$PATH:/root/.local/share/coursier/bin

COPY --from=repo /output/cs /usr/bin/

RUN cs setup --apps scala:2.12.15,scalac:2.12.15,sbt,sbtn,ammonite,scalafmt
