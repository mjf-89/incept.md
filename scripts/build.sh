#!/bin/sh
set -eu
cd "$(dirname "$0")/.."

mode=${1:-$(git branch --show-current)}
case "$mode" in
    main) set -- --baseURL https://incept.md/ --buildDrafts=false ;;
    draft) set -- --baseURL https://draft.incept.md/ --buildDrafts ;;
    *) printf 'Use main or draft as the build mode.\n' >&2; exit 1 ;;
esac

build_dir=$(mktemp -d /tmp/incept-hugo.XXXXXX)
trap 'rm -r -- "$build_dir"' EXIT
hugo "$@" --destination "$build_dir"
rsync -a --delete --chmod=D755,F644 "$build_dir/" public/
