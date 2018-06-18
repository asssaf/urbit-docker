FROM debian:stretch-slim as builder

RUN apt-get update
RUN apt-get -y install git libgmp3-dev libsigsegv-dev openssl libssl-dev libncurses5-dev \
  exuberant-ctags automake autoconf libtool g++ ragel re2c libcurl4-gnutls-dev curl \
  zlib1g-dev patch pkg-config

RUN echo 'deb http://http.debian.net/debian stretch-backports main contrib non-free' > /etc/apt/sources.list.d/stretch-backports.list
RUN apt-get update
RUN apt-get -y install -t stretch-backports meson ninja-build

RUN mkdir urbit \
	&& cd urbit \
	&& git init \
	&& git remote add origin https://github.com/urbit/urbit.git \
	&& git fetch --depth 1 origin tags/urbit-0.6.0 \
	&& git checkout FETCH_HEAD \
	&& git submodule update --init --depth 1 subprojects/*

WORKDIR /urbit
RUN sh ./scripts/build


FROM debian:stretch-slim

RUN apt-get update \
        && apt-get -y install openssl libsigsegv2 libgmp10 libcurl3-gnutls tmux \
        && rm -rf /var/lib/apt/lists/*

COPY --from=builder /urbit/build/urbit /usr/bin/

COPY entrypoint.sh /

ENV LANG C.UTF-8
WORKDIR /urbit
VOLUME /urbit

ENTRYPOINT [ "/entrypoint.sh" ]
