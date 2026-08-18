#!/usr/bin/env bash

if [[ -d "${HOME}/.secrets/" ]]; then
    for file in "${HOME}/.secrets/*.env"; do
        eval "$(cat $file)"
    done
fi
