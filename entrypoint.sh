#!/bin/sh
if [ "$1" = "-d" ]
then
	shift
	/usr/bin/tmux new-session "urbit $*"
	echo "terminated $?"
else
	exec /usr/bin/urbit $*
fi
