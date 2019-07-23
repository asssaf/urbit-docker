#!/bin/sh
if [ "$1" = "-d" ]
then
	shift
	tmux new-session "urbit $*"
	echo "terminated $?"
else
	exec urbit $*
fi
