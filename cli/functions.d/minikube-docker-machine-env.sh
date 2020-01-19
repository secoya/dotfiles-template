#!/bin/bash

if type minikube &>/dev/null; then
    if pgrep -qF "$HOME/.minikube/machines/minikube/hyperkit.pid" &>/dev/null || \
       pgrep -q docker-machine-driver-xhyve || \
       pgrep -qf -- 'VBoxHeadless --comment minikube'; then
        # Was [[ $(minikube status --format '{{.MinikubeStatus}}') == 'Running' ]]
        # previously, but that is way too slow
        eval "$(minikube docker-env)"
    fi
fi
