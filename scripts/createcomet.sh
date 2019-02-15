#!/usr/bin/env bash

if [ $# -ne 1 ]
then
	>&2 echo "Usage: $(basename $0) <comet>"
	exit 1
fi

SHIP="$1"
: ${URBIT_IMAGE:="asssaf/urbit:0.7.3-debian"}

docker run -ti --rm \
	--net host \
	-v $(pwd):/urbit \
	--user $(id -u):$(id -g) \
	${URBIT_IMAGE} -c ${SHIP}
