#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
EXT="$ROOT/ext"
HW_COMMIT=afb36ca   # 학기 중 원본이 바뀌어도 모든 학생이 같은 버전을 쓰도록 고정

sudo apt-get update
sudo apt-get install -y strace ltrace valgrind gdb make procps \
  python3 python-is-python3 python3-tk

mkdir -p "$EXT"
if [ ! -d "$EXT/ostep-homework/.git" ]; then
  git clone https://github.com/remzi-arpacidusseau/ostep-homework.git "$EXT/ostep-homework"
  git -C "$EXT/ostep-homework" checkout -q "$HW_COMMIT"
fi
if [ ! -d "$EXT/ostep-code/.git" ]; then
  git clone --depth 1 https://github.com/remzi-arpacidusseau/ostep-code.git "$EXT/ostep-code"
fi
