#!/usr/bin/env bash
set -euo pipefail
IFS=$'\t\n'

if [ ! -e ~/.fzf ]; then
  git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
  ~/.fzf/install
fi
