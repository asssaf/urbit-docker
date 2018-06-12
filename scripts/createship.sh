#!/usr/bin/env bash

if [ $# -ne 2 ]
then
	>&2 echo "Usage: $(basename $0) <ship> <code>"
	exit 1
fi

SHIP="$1"
CODE="$2"
IMAGE="asssaf/urbit"

docker run -ti --rm \
	--net host \
	-v $(pwd):/urbit \
	--user $(id -u):$(id -g) \
	${IMAGE} -w ${SHIP} -t ${CODE}
