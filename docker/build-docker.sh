#!/usr/bin/env bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $DIR/..

DOCKER_IMAGE=${DOCKER_IMAGE:-electrobytespay/electrobytesd-develop}
DOCKER_TAG=${DOCKER_TAG:-latest}

BUILD_DIR=${BUILD_DIR:-.}

rm docker/bin/*
mkdir docker/bin
cp $BUILD_DIR/src/electrobytesd docker/bin/
cp $BUILD_DIR/src/electrobytes-cli docker/bin/
cp $BUILD_DIR/src/electrobytes-tx docker/bin/
strip docker/bin/electrobytesd
strip docker/bin/electrobytes-cli
strip docker/bin/electrobytes-tx

docker build --pull -t $DOCKER_IMAGE:$DOCKER_TAG -f docker/Dockerfile docker
