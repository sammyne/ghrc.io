FROM busybox:1.36.0-glibc as builder

ENV VERSION v1.26.0

WORKDIR /output

RUN wget https://storage.googleapis.com/kubernetes-release/release/${VERSION}/bin/linux/amd64/kubectl

RUN chmod +x kubectl && cp kubectl /bin/ 

RUN kubectl version --client

FROM busybox:1.36.0-glibc

COPY --from=builder /output/kubectl /bin/kubectl
