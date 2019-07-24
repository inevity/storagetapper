#!/bin/bash

TIMEOUT=300s

for i in $@; do
#	CGO_ENABLED=0 gometalinter -e format_gen --deadline=$TIMEOUT --disable-all -Evetshadow -Evet -Egolint -Egoimports -Eineffassign -Egosimple -Eerrcheck -Eunused -Edeadcode -Emisspell -Egocyclo -Estaticcheck --cyclo-over=15 $i && echo "ok\t$i"
  #CGO_ENABLED=0 golangci-lint run $i && echo "ok\t$i"
  golangci-lint run --no-config --issues-exit-code=0 --deadline=30m --disable-all --enable=deadcode  --enable=gocyclo --enable=golint --enable=varcheck --enable=structcheck --enable=maligned --enable=errcheck --enable=dupl --enable=ineffassign --enable=interfacer --enable=unconvert --enable=goconst --enable=gosec --enable=megacheck $i && echo "ok\t$i"
  #CGO_ENABLED=0 golangci-lint run -e format_gen --deadline=$TIMEOUT --disable-all -Evetshadow -Evet -Egolint -Egoimports -Eineffassign -Egosimple -Eerrcheck -Eunused -Edeadcode -Emisspell -Egocyclo -Estaticcheck --cyclo-over=15 $i && echo "ok\t$i"
done
