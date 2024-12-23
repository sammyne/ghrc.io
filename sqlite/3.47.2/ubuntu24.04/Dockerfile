FROM ubuntu:24.04 AS rc

RUN sed -i 's/archive.ubuntu.com/mirrors.tencent.com/g' /etc/apt/sources.list.d/ubuntu.sources &&\
  sed -i 's/security.ubuntu.com/mirrors.tencent.com/g' /etc/apt/sources.list.d/ubuntu.sources


FROM rc AS downloader

RUN apt update && apt install -y wget unzip

WORKDIR /output

# 这个字符串和 SQLite 版本的关系参见这里 https://www.sqlite.org/download.html <Build Product Names and Info> 小节
ARG VERSION=3470200

RUN wget https://www.sqlite.org/2024/sqlite-tools-linux-x64-$VERSION.zip

RUN unzip sqlite-tools-linux-x64-$VERSION.zip

RUN rm -rf sqlite-tools-linux-x64-$VERSION.zip


FROM rc

ENV PATH=/opt/sqlite3:$PATH

COPY --from=downloader /output /opt/sqlite3

ENTRYPOINT ["sqlite3"]
