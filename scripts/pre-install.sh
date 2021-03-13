#!/bin/sh

source "${DIR}"/../.env

clear

TOTAL_STEPS=1
CURRENT_STEP=0

CURRENT_STEP=$((CURRENT_STEP + 1))

sessions=$(lsof -i -P -n | grep :4000)

if [ "$sessions" ]; then
	killall node -9
fi
