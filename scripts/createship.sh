#!/usr/bin/env bash

if [ $# -ne 2 ]
then
	>&2 echo "Usage: $(basename $0) <ship> <keyfile>"
	exit 1
fi

SHIP="$1"
KEY_FILE="$2"
: ${URBIT_IMAGE:="asssaf/urbit:0.8.0-nix"}

if [ ! -f "$KEY_FILE" ]
then
	>&2 echo "Key file is not readable: '$KEY_FILE'"
	exit 2
fi

ABS_KEY_FILE="$(readlink -e $KEY_FILE)"

docker run -ti --rm \
	--net host \
	-v $(pwd):/urbit \
        -v "$ABS_KEY_FILE:/mnt/key_file:ro" \
	--user $(id -u):$(id -g) \
	${URBIT_IMAGE} -w ${SHIP} -k /mnt/key_file
