FROM danielguerra/alpine-sdk-build:edge as apkbuilder

USER root

# libsigsegv is available in testing branch
RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories

# fix a build issue
RUN sed -i 's/\(export CFLAGS=".*\)"/\1 -D_GNU_SOURCE"/' /etc/abuild.conf

RUN apk update

USER sdk
COPY apkbuild/APKBUILD /home/sdk/APKBUILD

# calling through the entrypoint script that handles private key generation
RUN /usr/local/bin/docker-entrypoint.sh abuild -r


FROM alpine:edge

ENV PV=0.5.1-r0

# libsigsegv is available in testing branch
RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories

RUN apk add --no-cache libsigsegv gmp openssl ncurses curl tmux
COPY --from=apkbuilder /home/sdk/packages/home/x86_64/urbit-$PV.apk /
RUN apk add --no-cache --allow-untrusted /urbit-$PV.apk

RUN rm /urbit-$PV.apk
COPY entrypoint.sh /

WORKDIR /urbit
VOLUME /urbit

ENTRYPOINT [ "/entrypoint.sh" ]
