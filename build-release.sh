#!/bin/sh

set -e

VERSION=$(cat VERSION)

echo "Building convoy currently requires go version 1.22.3 and is incompatible with go 1.23 due to a dependency"

export GOOS=linux GOARCH=amd64
scripts/build.sh -b ce

docker buildx build \
 --no-cache \
 --platform linux/amd64 \
 --rm=true \
 --file=release.Dockerfile \
 -t 137987605457.dkr.ecr.us-east-1.amazonaws.com/convoy:$VERSION-base \
 .
docker push 137987605457.dkr.ecr.us-east-1.amazonaws.com/convoy:$VERSION-base
