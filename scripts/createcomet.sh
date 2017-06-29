#!/usr/bin/env bash

if [ $# -ne 1 ]
then
	>&2 echo "Usage: $(basename $0) <comet>"
	exit 1
fi

SHIP="$1"
IMAGE="asssaf/urbit-alpine"

docker run -ti --rm \
	--net host \
	-v $(pwd):/urbit \
	--user $(id -u):$(id -g) \
	${IMAGE} -c ${SHIP}
