FROM nixos/nix:latest as builder

WORKDIR /tmp
RUN wget -O - https://github.com/urbit/urbit/archive/v0.8.0.tar.gz | tar xz
RUN nix-env -f urbit-0.8.0 -iA urbit -iA herb
RUN nix-env -i tmux

# create closure but exclude build time dependencies
RUN nix-store -qR $(type -p urbit herb tmux) \
  | grep -v 'gcc-.*[0-9]$' \
  | grep -v 'glibc-.*-dev' \
  | grep -v 'linux-headers'\
  | grep -v 'source' \
  > all

RUN mkdir output
RUN for F in $(cat all); do cp -a $F output/ ; done

FROM nixos/nix:latest
COPY --from=builder /tmp/output /nix/store
COPY --from=builder /root/.nix-profile /root/.nix-profile

COPY entrypoint.sh /

ENV LANG C.UTF-8
WORKDIR /urbit
VOLUME /urbit

ENTRYPOINT [ "/entrypoint.sh" ]
