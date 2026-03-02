#!/usr/bin/env bash

set -euo pipefail

DARWIN_PKGS=('emacs' 'vim' 'zsh' 'tmux' 'starship' 'wget' 'radare2')
VIM_IT_SPELL_URL='https://raw.githubusercontent.com/vim/vim/master/runtime/spell/it.utf-8.spl'
ASSUME_YES=0

usage() {
  cat <<EOF
Usage: $(basename "$0") [--yes]

Options:
  --yes      Non-interactive mode. Use defaults for missing XDG paths.
  -h, --help Show this help.
EOF
}

for arg in "$@"; do
  case "$arg" in
    --yes) ASSUME_YES=1 ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      echo "[!] Unknown option: $arg"
      usage
      exit 1
      ;;
  esac
done

require_cmd() {
  local cmd=$1
  if ! command -v "$cmd" >/dev/null 2>&1; then
    echo "[!] Please install $cmd!"
    exit 1
  fi
}

prompt_or_default() {
  local var_name=$1
  local default_value=$2
  local input=""

  if [[ $ASSUME_YES -eq 0 ]]; then
    read -r -p "[!] ${var_name} (Enter for default: ${default_value}): " input
  fi

  printf '%s' "${input:-$default_value}"
}

stow_package() {
  local pkg=$1
  if [[ -d "$pkg" ]]; then
    if ! stow -v 1 -R -t "$HOME" "$pkg"; then
      echo "[!] stow failed for package: $pkg"
    fi
  fi
}

run_common_scripts() {
  local script
  while IFS= read -r -d '' script; do
    if [[ -x "$script" ]]; then
      "$script"
    fi
  done < <(find ./common -type f -print0)
}

require_cmd stow
require_cmd curl
require_cmd git

echo "[-] Start stowing"
if [[ "$(uname -s)" == 'Darwin' ]]; then
  for pkg in "${DARWIN_PKGS[@]}"; do
    stow_package "$pkg"
  done
else
  while IFS= read -r dir; do
    stow_package "$dir"
  done < <(find . -mindepth 1 -maxdepth 1 -type d ! -name 'common' ! -name '.git' -printf '%f\n')
fi
echo "[+] Done stowing"

echo "[-] Setting XDG dirs"

export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$(prompt_or_default XDG_CACHE_HOME "$HOME/.cache")}"
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$(prompt_or_default XDG_CONFIG_HOME "$HOME/.config")}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-$(prompt_or_default XDG_DATA_HOME "$HOME/.local/share")}"

mkdir -p "$XDG_CACHE_HOME/vim" \
  "$XDG_DATA_HOME/vim" \
  "$XDG_DATA_HOME/vim/spell" \
  "$XDG_DATA_HOME/vim/pack" \
  "$XDG_DATA_HOME/zsh" \
  "$XDG_CONFIG_HOME"

echo "[+] Done setting XDG dirs"

echo "[-] Setting up vim"
if [[ ! -f "$XDG_DATA_HOME/vim/spell/it.utf-8.spl" ]]; then
  curl -fsSL "$VIM_IT_SPELL_URL" -o "$XDG_DATA_HOME/vim/spell/it.utf-8.spl"
fi
echo '[+] Done setting up vim'

echo '[-] Setting up tmux'
if [[ ! -d "${XDG_CONFIG_HOME}/tmux/plugins/tpm" ]]; then
  git clone --depth 1 https://github.com/tmux-plugins/tpm "${XDG_CONFIG_HOME}/tmux/plugins/tpm"
fi
echo '[+] Done setting up tmux'

echo '[-] Do common things'
run_common_scripts

echo '[+] All done!'
