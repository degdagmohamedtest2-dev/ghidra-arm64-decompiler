#!/usr/bin/env bash
set -euo pipefail

ghidra_source="${1:-${GHIDRA_SOURCE_DIR:-}}"
if [[ -z "$ghidra_source" ]]; then
  echo "usage: $0 /path/to/ghidra-source" >&2
  exit 2
fi

if [[ ! -x "$ghidra_source/gradlew" ]]; then
  echo "Ghidra source checkout with gradlew required: $ghidra_source" >&2
  exit 2
fi

cd "$ghidra_source"
chmod +x gradlew
LC_MESSAGES=en_US.UTF-8 ./gradlew buildNatives_linux_arm_64 --no-daemon --stacktrace

native_dir="Ghidra/Features/Decompiler/build/os/linux_arm_64"
for name in decompile sleigh; do
  test -x "$native_dir/$name" || {
    echo "missing $native_dir/$name" >&2
    exit 1
  }
done

echo "Built Linux ARM64 natives in $ghidra_source/$native_dir"
