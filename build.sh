#!/usr/bin/env sh
set -eux
elm make ./src/Main.elm --output=./dist/main.js
