FROM busybox:1.33.0 as getter

WORKDIR /root/sammyne

ENV REPO=https://developer.arm.com/-/media/Files/downloads/gnu-a \
  TAG=9.2-2019.12

ENV archive=gcc-arm-$TAG-x86_64-arm-none-linux-gnueabihf

RUN wget $REPO/$TAG/binrel/$archive.tar.xz
RUN tar xf $archive.tar.xz
#ADD $archive.tar.xz .

WORKDIR /root/sammyne/$archive/bin

RUN for f in *-none-linux*; do ln -s $f ${f//-none}; done;

WORKDIR /root/sammyne

RUN mv $archive gcc

RUN tar -zcvf gcc.tar.gz gcc

FROM scratch

WORKDIR /

COPY --from=getter /root/sammyne/gcc.tar.gz .
