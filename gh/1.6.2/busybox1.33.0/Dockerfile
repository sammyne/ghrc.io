FROM busybox:1.33.0 as builder

WORKDIR /root/sammyne

ENV TAG=1.6.2

RUN wget https://hub.fastgit.org/cli/cli/releases/download/v${TAG}/gh_${TAG}_linux_amd64.tar.gz

RUN tar -zxvf gh_${TAG}_linux_amd64.tar.gz  &&\
  cp gh_${TAG}_linux_amd64/bin/gh /bin/     &&\
  gh --version

FROM alpine:3.13.2 as tls

RUN apk update && apk add ca-certificates

FROM busybox:1.33.0

WORKDIR /root/sammyne

COPY --from=tls /etc/ssl/certs /etc/ssl/certs

COPY --from=builder /bin/gh /bin/

CMD gh
