# My dotfiles
Personal Linux/macOS dotfiles managed with GNU Stow.

## Prerequisites
- `stow`
- `curl`
- `git`

## Usage
```bash
git clone --recurse-submodules https://github.com/therealbobo/dotfiles .dotfiles
cd .dotfiles
./restore_dotfiles.sh
```

## Non-interactive install
```bash
./restore_dotfiles.sh --yes
```

Optional: set XDG paths before running, for example:
```bash
XDG_CONFIG_HOME="$HOME/.config" XDG_DATA_HOME="$HOME/.local/share" ./restore_dotfiles.sh --yes
```
