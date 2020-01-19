#!/bin/bash

if type docker &>/dev/null; then
    rm-dead-docker-containers() {
        docker ps -a -q --filter "status=exited" --filter "status=dead" | xargs docker rm
    }
fi
