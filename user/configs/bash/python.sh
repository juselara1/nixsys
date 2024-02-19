#!/usr/bin/env bash

# activate python environments
activate() {
    pushd . "$@" > /dev/null
    gr
    source ".venv/bin/activate"
    popd "$@" > /dev/null
}

# python venv
localpy() {
    python -m venv .venv
}
