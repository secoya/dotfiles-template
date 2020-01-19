#!/usr/bin/env zsh

function reload-completion() {
	autoload -U +X compinit && compinit
}
