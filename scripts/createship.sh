#!/usr/bin/env bash

if [ $# -ne 2 ]
then
	>&2 echo "Usage: $(basename $0) <ship> <code>"
	exit 1
fi

SHIP="$1"
CODE="$2"
: ${URBIT_IMAGE:="asssaf/urbit:0.6.0-debian"}

docker run -ti --rm \
	--net host \
	-v $(pwd):/urbit \
	--user $(id -u):$(id -g) \
	${URBIT_IMAGE} -w ${SHIP} -t ${CODE}
