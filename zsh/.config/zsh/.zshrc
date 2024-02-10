if [[ "$TERM" == "dumb" ]]; then
  unsetopt zle
  unsetopt prompt_cr
  unsetopt prompt_subst
  if whence -w precmd >/dev/null; then
      unfunction precmd
  fi
  if whence -w preexec >/dev/null; then
      unfunction preexec
  fi
  PS1='$ '
  unset zle_bracketed_paste
  unsetopt rcs
  return
fi

### SOURCES ###{{{
source "$XDG_CONFIG_HOME/zsh/aliases"
source "$XDG_CONFIG_HOME/zsh/vars.zsh"
source "$XDG_CONFIG_HOME/zsh/zstyles.zsh"
###}}}

PROMPT='%f'
PROMPT+='%F{red}%B%n'                 # username
PROMPT+='%(?.%F{red}@.%F{black}@)%f'  # @
PROMPT+='%F{red}%M%b%f:'              # hostname
PROMPT+='%F{blue}%2~%f %# '             # pwd

if [[ "$TERM" != "tramp" ]]; then
	command -v starship 1>/dev/null && \
		eval "$(starship init zsh)"
fi
eval "$(zoxide init zsh)"

# TODO mv histfile
[ ! -f "$XDG_DATA_HOME"/zsh/histfile ] && touch "$XDG_DATA_HOME"/zsh/histfile
HISTFILE="$XDG_DATA_HOME"/zsh/histfile
HISTSIZE=10000000
SAVEHIST=10000000
setopt BANG_HIST                 # Treat the '!' character specially during expansion.
setopt EXTENDED_HISTORY          # Write the history file in the ":start:elapsed;command" format.
setopt INC_APPEND_HISTORY        # Write to the history file immediately, not when the shell exits.
setopt SHARE_HISTORY             # Share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire duplicate entries first when trimming history.
setopt HIST_IGNORE_DUPS          # Don't record an entry that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS      # Delete old recorded entry if new entry is a duplicate.
setopt HIST_FIND_NO_DUPS         # Do not display a line previously found.
setopt HIST_IGNORE_SPACE         # Don't record an entry starting with a space.
setopt HIST_SAVE_NO_DUPS         # Don't write duplicate entries in the history file.
setopt HIST_REDUCE_BLANKS        # Remove superfluous blanks before recording entry.
setopt HIST_VERIFY               # Don't execute immediately upon history expansion.
setopt HIST_BEEP                 # Beep when accessing nonexistent history.

KEYTIMEOUT=50


setopt autocd notify
bindkey -v
bindkey '^R' history-incremental-search-backward

# plugins
source $ZDOTDIR/plugins/sudo.zsh
source $ZDOTDIR/plugins/fzf.zsh

# edit command commands in vim
autoload -U edit-command-line
zle -N edit-command-line
bindkey -M vicmd v edit-command-line

# window title
precmd() { print -Pn "\e]0;%~\a" }
preexec() { echo -en "\e]0;${1}\a" }

# autocompletion
autoload -Uz compinit
compinit -d $ZSH_COMPDUMP
_comp_options+=(globdots)

[[ -r "/usr/share/z/z.sh" ]] && source /usr/share/z/z.sh
