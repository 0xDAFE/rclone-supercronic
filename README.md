# rclone-supercronic

## Motivation

This image provides an easy way to have a docker container run periodic rclone scripts and the ability to run as an arbitrary user (in particular non-root).

## How do I use it?

1. Write a bash script that does what you want, e.g. multiple rclone commands to copy / move your stuff.
2. Edit the crontab file to match your needs. You can also use pre-configured directories like `/etc/periodic/daily`
3. Mount your script(s) into the appropriate paths inside the container

Example (bare docker command):
```sh
docker run -e PUID=$(id -u) -e PGID=$(id -g) -v ${PWD}/crontab:/etc/supercronic/crontab -v ${PWD}/hello.sh:/etc/periodic/custom/hello.sh --rm -it gibibyte/rclone-supercronic
```

## Technical background

The Dockerfile adds [supercronic](https://github.com/aptible/supercronic) on top of the official [rclone](https://github.com/rclone/rclone) Docker image and an entrypoint using `su-exec` to drop root privileges.
