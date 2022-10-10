# ref: https://youtrack.jetbrains.com/issue/GTW-780/Provide-docker-image-for-host
# ref: https://www.jetbrains.com/help/idea/2022.2/remote-development-a.html#use_idea

FROM alpine:3.16.0 AS repo

WORKDIR /output

RUN apk add curl

ENV VERSION=2022.3

RUN curl -fsSL -o idea.tar.gz https://download.jetbrains.com/idea/ideaIU-$VERSION.tar.gz

RUN mkdir idea                                                                              &&\
    tar xfz idea.tar.gz --strip-components=1 -C idea                                        &&\
    rm idea.tar.gz

FROM sammyne/scala:2.12.15-konajdk8.0.11-ubuntu20.04

RUN apt-get update &&\
    DEBIAN_FRONTEND=noninteractive apt-get install -y git curl unzip procps time mc strace maven

COPY --from=repo /output/idea /idea

# ref: https://youtrack.jetbrains.com/issue/GTW-936/20213-Headless-server-Need-a-way-to-bypass-Press-ENTER-to-continue
ENV CWM_TRUST_PROJECTS=1

WORKDIR /workspace

# searching plugin id (such as 'org.intellij.scala') refers to
# https://plugins.jetbrains.com/docs/intellij/plugin-dependencies.html#1-locating-plugin-id-and-preparing-sandbox
RUN /idea/bin/remote-dev-server.sh installPlugins /workspace org.intellij.scala IdeaVIM

ADD gitignore /workspace/.gitignore

EXPOSE 5993

ENTRYPOINT ["/idea/bin/remote-dev-server.sh", "run", "/workspace", "--listenOn", "0.0.0.0", "--port", "5993"]
