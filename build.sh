#!/bin/sh

DOCKER_HUB_PROJECT=snowdreamtech/mysql
DOCKER_HUB_PROJECT1=snowdreamtech/mariadb
GITHUB_PROJECT=ghcr.io/snowdreamtech/mysql
GITHUB_PROJECT1=ghcr.io/snowdreamtech/mariadb

docker buildx build --platform=linux/386,linux/amd64,linux/arm/v6,linux/arm/v7,linux/arm64,linux/ppc64le,linux/riscv64,linux/s390x \
    -t ${DOCKER_HUB_PROJECT}:latest \
    -t ${DOCKER_HUB_PROJECT}:10.11.8 \
    -t ${DOCKER_HUB_PROJECT}:10.11 \
    -t ${DOCKER_HUB_PROJECT}:10 \
    -t ${GITHUB_PROJECT}:latest \
    -t ${GITHUB_PROJECT}:10.11.8 \
    -t ${GITHUB_PROJECT}:10.11 \
    -t ${GITHUB_PROJECT}:10 \
    -t ${DOCKER_HUB_PROJECT1}:latest \
    -t ${DOCKER_HUB_PROJECT1}:10.11.8 \
    -t ${DOCKER_HUB_PROJECT1}:10.11 \
    -t ${DOCKER_HUB_PROJECT1}:10 \
    -t ${GITHUB_PROJECT1}:latest \
    -t ${GITHUB_PROJECT1}:10.11.8 \
    -t ${GITHUB_PROJECT1}:10.11 \
    -t ${GITHUB_PROJECT1}:10 \
    . \
    --push
