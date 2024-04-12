#!/usr/bin/env bash

read -p "Destroy everything? Input 'yes' to confirm:" input
if [[ "$input" != "yes" ]]; then
    echo "Aborted."
    exit
fi

set -eux

docker compose down -v

sudo rm -rf config custom_apps data
