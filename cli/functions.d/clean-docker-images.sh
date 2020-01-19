#!/bin/bash

if type docker &>/dev/null; then
    clean-docker-images() {
        docker images -q --filter "dangling=true" | xargs docker rmi
    }
fi
