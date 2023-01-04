FROM busybox:1.35.0 AS repo

WORKDIR /output 

# newer version requires GLIBC>=2.32, while ubuntu:20.04 has only GLIBC==2.30
ENV REV=a827601d2f3d05a92df8f1d46cdd256afb1716b0

RUN wget -O - https://raw.githubusercontent.com/coursier/launchers/$REV/cs-x86_64-pc-linux.gz | \
  gzip -d > cs                                                                                &&\
  chmod u+x cs

FROM sammyne/openjdk:8-222-b10-zulu8.40.0.25-ubuntu20.04

ENV PATH=$PATH:/root/.local/share/coursier/bin

COPY --from=repo /output/cs /usr/bin/cs

RUN cs setup --apps scala:2.12.10,scalac:2.12.10,sbt:1.7.1,sbtn,ammonite,scalafmt:3.5.8
