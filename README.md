# docker bats sample

This repository demonstrates testing a docker container with [bats](https://github.com/sstephenson/bats).

## Requirements

* [Docker](https://www.docker.com/)
* [GNU Make](https://www.gnu.org/software/make/)

## Usage

```bash
make run
```

This command builds the image, creates and starts the container.

```bash
make verify
```

Verify installs bats in the container and executes the test suite.


```bash
make test
```

Make test builds the docker image, creates and starts the container, installs bats and execute the tests.
This command is mostly useful for ci.

```bash
make clean
````

Clean stops and removes the containers.
