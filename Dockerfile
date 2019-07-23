FROM nixos/nix:latest as builder

ARG branch
RUN nix-env -iA nixpkgs.git
RUN nix-env -iA nixpkgs.git-lfs

RUN git clone --branch ${branch} --depth 1 https://github.com/urbit/urbit.git /tmp/urbit

WORKDIR /tmp/urbit

RUN git lfs install
RUN git lfs pull

RUN nix-env -f . -iA urbit -iA herb

ADD docker.nix /tmp/urbit/docker.nix
RUN nix-build docker.nix
RUN mkdir /image /output
RUN tar xzf result -C /image
RUN tar xf /image/*/layer.tar -C /output


# create minimal image
FROM busybox

COPY --from=builder /output /

COPY entrypoint.sh /

ENV LANG C.UTF-8
WORKDIR /urbit
VOLUME /urbit

ENTRYPOINT [ "/entrypoint.sh" ]
