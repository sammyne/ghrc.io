FROM busybox:1.35.0 AS repo

WORKDIR /output

ENV REV=76847f89ee9f8ee6dbc94e5a5ac464162d49727b

RUN wget -O - https://raw.githubusercontent.com/coursier/launchers/$REV/cs-x86_64-pc-linux.gz | gzip -d > cs

RUN chmod u+x cs

FROM sammyne/openjdk:11.0.2-9-ubuntu20.04

ENV PATH=$PATH:/root/.local/share/coursier/bin

COPY --from=repo /output/cs /usr/bin/

RUN cs setup --apps scala:3.1.1,scalac:3.1.1,sbt:1.7.1,sbtn:1.7.1,ammonite:2.5.4,scalafmt:3.5.8
