FROM busybox:1.36.0 AS repo

ENV SPARK_VERSION=3.1.3

WORKDIR /output

RUN wget -O - https://archive.apache.org/dist/spark/spark-${SPARK_VERSION}/spark-${SPARK_VERSION}-bin-hadoop3.2.tgz > spark.tgz


FROM busybox:1.36.0

WORKDIR /output

COPY --from=repo /output/spark.tgz ./
