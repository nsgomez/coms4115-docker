# COMS W4115 Docker container

This repository provides a Docker container and basic OPAM environment that
allows you to build and test languages written in OCaml with OCamlyacc.
Specifically, this image is tuned for use with CircleCI continuous integration
and a language based on MicroC.

This image is available on Docker Cloud at
[https://cloud.docker.com/swarm/nsgomez/coms4115-docker](nsgomez/coms4115-docker).

## Usage

If using the Docker image on CircleCI as recommended, create a
`.circleci/config.yml` file in your repository with the following lines:

```
version: 2.0
jobs:
    build:
        docker:
            - image: nsgomez/coms4115-docker:stable
```

Additional details on how to set up a continuous integration workflow with
CircleCI can be found in [CircleCI documentation](https://circleci.com/docs/2.0/).

If not using CircleCI, the image can be built and run by using the following
commands:

```
docker build -t coms4115-docker .
docker run -it coms4115-docker /bin/bash
```

This will build the image and start a bash session within it. However, it's not
recommended to use this image as a developer workspace due to the lack of
userspace tools and documentation.

## Customization

Customizations for additional package or OPAM dependencies should be added to
the bottom of the Dockerfile. Placing commands above that point will cause
unnecessarily long image build times due to the cached containers for the
commands above that being invalidated.
