# urbit-docker
[![Docker Build Status](https://img.shields.io/docker/build/asssaf/urbit.svg?style=flat)](https://hub.docker.com/r/asssaf/urbit/)
[![latest tag](https://img.shields.io/badge/latest-urbit--os--v1.0.16--nix-blue.svg)](https://hub.docker.com/r/asssaf/urbit/tags/)

Minimal docker image for running [Urbit](https://urbit.org)

**Warning: Make sure you mount a volume for the `/urbit/$SHIP` directory in the container, otherwise you may lose the urbit's key and state unrecoverably! **. The provided create/run scripts do that for you, but be careful if running a custom docker command.

This container builds an APK and installs it. See the APK section for details on building the apk separately.

## Scripts
The `scripts/` directory contains scripts for running and creating ships (by mapping the current directory as a volume inside the container).

```
$ scripts/createcomet.sh mycomet
...

$ scripts/run myship
...
```

A non-default image can be selected by setting the `URBIT_IMAGE` environment variable.

### Run as daemon
```
$ scripts/run-daemon myship
<container-id>
```

Attach to the running daemon using the `<container-id>` from the run-daemon output:
```
$ docker exec -ti <container-id> tmux attach
```

Detach from the session using the tmux binding `C-b d`

## Image Variants
### Debian
Images tagged with `<version>-debian`, e.g. `0.6.0-debian`

This is the default since urbit version 0.6.0. Debian images are around 73MB.

### Alpine
Alpine images are considerably smaller in size (around 15MB). They are not supported yet for urbit version 0.6.0.

#### APK
If you want to build the apk used by the container by yourself, you can find in the `apkbuild/` directory the APKBUILD script and a Makefile to build the apk using docker.

```
$ cd apkbuild
$ make
...
$ ls packages/home/x86_64/
APKINDEX.tar.gz  urbit-0.4.5-r0.apk
```
