#!/bin/sh

declare -A icons=(
["fish"]="󰈺"
["bash"]=""
["tmux"]=""
["nvim"]=""
["vim"]=""
["git"]="󰊢"
["lazygit"]="󰊢"
["man"]=""
["nix"]=""
["nix-shell"]=""
["node"]="󰎙"
["lua"]="󰢱"
["python"]=""
["python3"]=""
["docker"]=""
["docker-compose"]=""
)

if [[ ${icons[$1]} ]]; then
  echo "${icons[$1]}"
else
  echo $2
fi
