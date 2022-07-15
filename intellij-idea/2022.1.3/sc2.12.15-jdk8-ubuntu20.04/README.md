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
1. Connect to started IDEA in local machine using Jetbrains Gateway
1. Change the default JDK in `Project Structure / Project Settings / Project / SDK` to the installed `1.8`

## References
- [2021.3 Headless server: Need a way to bypass "Press ENTER to continue"](https://youtrack.jetbrains.com/issue/GTW-936/20213-Headless-server-Need-a-way-to-bypass-Press-ENTER-to-continue)
- [Connect to a remote project at manually launched remote IDE (Server-to-client flow)](https://www.jetbrains.com/help/idea/2022.2/remote-development-a.html#use_idea)
- [Provide docker image for host](https://youtrack.jetbrains.com/issue/GTW-780/Provide-docker-image-for-host)
