FROM alpine:edge

ENV PV=0.4.5-r0

# libsigsegv is available in testing branch
RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories

RUN apk add --no-cache libsigsegv gmp openssl ncurses curl
RUN wget https://github.com/asssaf/urbit-docker-alpine/releases/download/$PV/urbit-$PV.apk
RUN apk add --no-cache --allow-untrusted /urbit-$PV.apk

RUN rm /urbit-$PV.apk

WORKDIR /urbit
ENTRYPOINT [ "urbit" ]

