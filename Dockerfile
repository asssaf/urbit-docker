FROM alpine:edge

COPY urbit-0.4.5-r0.apk /

# libsigsegv is available in testing branch
RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories

RUN apk add --no-cache libsigsegv gmp openssl ncurses curl \
	&& apk add --no-cache --allow-untrusted /urbit-0.4.5-r0.apk

RUN rm /urbit-0.4.5-r0.apk

