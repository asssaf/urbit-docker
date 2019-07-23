#!/usr/bin/env bash

if [ $# -ne 1 ]
then
	>&2 echo "Usage: $(basename $0) <comet>"
	exit 1
fi

SHIP="$1"
: ${URBIT_IMAGE:="asssaf/urbit:0.8.0-nix"}

docker run -ti --rm \
	--net host \
	-v $(pwd):/urbit \
	--user $(id -u):$(id -g) \
	${URBIT_IMAGE} -c ${SHIP}
