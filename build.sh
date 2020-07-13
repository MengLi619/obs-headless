#!/usr/bin/env sh
set -e

docker build --rm -t ${REGISTRY:-local}/obs-headless:${BUILDNUMBER:-dev} .
