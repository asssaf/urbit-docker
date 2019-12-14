FROM debian:buster-slim

RUN apt-get update \
        && apt-get -y install wget tmux \
        && rm -rf /var/lib/apt/lists/*

RUN wget -O - https://bootstrap.urbit.org/urbit-linux64-v0.10.1.tgz \
        | tar xvz -C /usr/bin/

COPY entrypoint.sh /

ENV LANG C.UTF-8
WORKDIR /urbit
VOLUME /urbit

ENTRYPOINT [ "/entrypoint.sh" ]
