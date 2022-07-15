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