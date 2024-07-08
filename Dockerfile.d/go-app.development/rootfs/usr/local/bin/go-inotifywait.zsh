#!/usr/bin/env -S zsh -eu

while true
do
  inotifywait --recursive --event modify,close_write,move,create,delete . && go test
done
