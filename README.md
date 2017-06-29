# urbit-alpine-docker
Minimal alpine linux based image for running [Urbit](https://urbit.org)

The container pulls the urbit apk from the releases links of this github repository (see the APK section for details on building the apk).

## Scripts
The `scripts/` directory contains scripts for running and creating ships (by mapping the current directory as a volume inside the container).

```
$ scripts/createcomet.sh mycomet
...

$ scripts/run myship
...
```

## APK
If you want to build the apk used by the container by yourself, you can find in the `apkbuild/` directory the APKBUILD script and a Makefile to build the apk using docker.

```
$ cd apkbuild
$ make
...
$ ls packages/home/x86_64/
APKINDEX.tar.gz  urbit-0.4.5-r0.apk
```
