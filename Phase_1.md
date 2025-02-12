# Phase 1

## Prerequisites

On a Debian 12 (bookworm) based system the following software is required to create a successful Docker container.

- openjdk-17-jre-headless
- make
- curl
- docker.io
- docker-compose

Start docker: `sudo systemctl start docker`

## Build The Java Application

- Clone this repository
- change directory into the repository
- Enter `make build`

## Build the Docker Container

**NOTE:** The only way I could reliably get the docker image to build was to run the work as the root user. This is not good practice and a proper solution needs to be found.

- `make docker`

## Docker Compose

A Docker compose file is used to configure the image to run and the network ports used on the local computer and inside the container.

```
services:
  interview:
    image: platform-interview:0.0.1-SNAPSHOT
    ports:
      - 8090:8080
```

There are two lines that matter most:

- `image`
  - This tells Docker which image, including tag, to run. If the Java application will use a different version, this value must be updated to match
- `ports`
  - The number on the left hand side (8090) of the colon is the port the local computer will listen
  - The number on the right hand side (8080) of the colon in the port the application in the container will listen

## Run the Docker Container

This can be run in two different ways.

- The application runs in the foreground

  - `docker-compose up`
  - `make run`

- The application runs in the background

  - `docker-compose up -d`

### Verify the Container Is Running

The user can verify the application is running by using the curl command to access the local port. The docker-compose.yml file is configured to use port 8090 for the local port.

```
# curl localhost:8090
Welcome to the Platform team!
```

It is also possible to look and the running Docker containers to see which ports are being used. The key column here is PORTS.

```
# docker ps
CONTAINER ID   IMAGE                               COMMAND              CREATED              STATUS              PORTS                                       NAMES
35a984cccd8c   platform-interview:0.0.1-SNAPSHOT   "/cnb/process/web"   About a minute ago   Up About a minute   0.0.0.0:8090->8080/tcp, :::8090->8080/tcp   platform-interview_interview_1
```

## Stop the Docker Container

- `docker-composen down`
- `make stop`

## Questions

The user in question has stated that they do not believe the docker command works. Even with a consistent way of building and running the container by way of a Makefile and Docker compose, the user can still run into problems.

- Is the user already running a service on port 8080?
- Did the user run into a problem with either the `bootJar` or `bootBuildImage` gradlew commands?
