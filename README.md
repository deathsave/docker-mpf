docker-mpf
==========

WORK IN PROGRESS

This is an attempt to create a Docker container that can run the
Mission Pinball Framework (MPF).

### Build

Build container with `docker build -t docker-mpf .`

### Docker Compose

In your machine folder, create a `docker-compose.yml` file with the
following:

```yaml
version: "3.8"

services:
  mpf:
    image: docker-mpf:latest
    # run both mpf and mpf-mc, in smart virtual
    # with basic logging against development config
    command: mpf both -Xta
    volumes:
    - ./:/usr/src/machine
    environment:
    # will be different for linux/windows
    - DISPLAY=docker.for.mac.host.internal:0
  mpf-monitor:
    image: docker-mpf:latest
    command: mpf monitor
    volumes:
    - ./:/usr/src/machine
```

### Mac Setup

Details about forwarding the X11 socket to the container can be
found here:
https://gist.github.com/sorny/969fe55d85c9b0035b0109a31cbcb088

However, at least on my M1 Mac, Kivy complains about the OpenGL
version not being supported.
