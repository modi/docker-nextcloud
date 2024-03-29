#!/usr/bin/env bash

if [[ -d "data" ]]; then
    echo "Directory 'data' exists, please check."
    exit
fi

set -eux

sudo mkdir data && sudo chown 33:33 data

docker compose up -d
