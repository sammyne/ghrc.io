FROM alpine:3.12.3 as builder

#RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.tuna.tsinghua.edu.cn/g' /etc/apk/repositories

ENV VERSION v1.17.9

WORKDIR /workspace

RUN apk update && apk add curl

RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/${VERSION}/bin/linux/amd64/kubectl

RUN chmod +x kubectl &&\
  cp kubectl /bin/ 

RUN kubectl version

FROM alpine:3.12.3

COPY --from=builder /workspace/kubectl /bin/kubectl
