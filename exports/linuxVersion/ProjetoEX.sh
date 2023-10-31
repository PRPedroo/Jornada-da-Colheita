#!/bin/sh
echo -ne '\033c\033]0;ProjetoEX\a'
base_path="$(dirname "$(realpath "$0")")"
"$base_path/ProjetoEX.x86_64" "$@"
