#!/bin/sh
set -eu
cd "$(dirname "$0")/.."
build_dir=$(mktemp -d /tmp/incept-hugo.XXXXXX)
trap 'rm -r -- "$build_dir"' EXIT
hugo --baseURL https://draft.incept.md/ --buildDrafts --destination "$build_dir"
rsync -a --delete --chmod=D755,F644 "$build_dir/" public/
