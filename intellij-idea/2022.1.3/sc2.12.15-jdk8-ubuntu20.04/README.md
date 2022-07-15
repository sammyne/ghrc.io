# Intellij IDEA

## Quickstart

1. Pack up the docker image
    ```bash
    docker build -t intellij-idea:2022.1.3-alpha .
    ```
1. Run the docker image in remote host
    ```bash
    docker run -it --rm -p 5993:5993 --name idea intellij-idea:2022.1.3-alpha
    ```
    Follow the prompt by pressing `ENTER` key to bootstrap the server.
1. Connect to started IDEA in local machine using Jetbrains Gateway
1. Change the default JDK in `Project Structure / Project Settings / Project / SDK` to the installed `1.8`

## References
- [Provide docker image for host](https://youtrack.jetbrains.com/issue/GTW-780/Provide-docker-image-for-host)
- [Connect to a remote project at manually launched remote IDE (Server-to-client flow)](https://www.jetbrains.com/help/idea/2022.2/remote-development-a.html#use_idea)