
### SOURCES ###{{{
source "$XDG_CONFIG_HOME/zsh/aliases"
source "$XDG_CONFIG_HOME/zsh/vars.zsh"
source "$XDG_CONFIG_HOME/zsh/zstyles.zsh"
###}}}

PROMPT='%f'
PROMPT+='%F{green}%B%n'                 # username
PROMPT+='%(?.%F{green}@.%F{black}@)%f'  # @
PROMPT+='%F{green}%M%b%f:'              # hostname
PROMPT+='%F{blue}%2~%f %# '             # pwd

# TODO mv histfile
[ ! -f "$XDG_DATA_HOME"/vim/histfile ] && touch "$XDG_DATA_HOME"/vim/histfile
HISTFILE="$XDG_DATA_HOME"/vim/histfile
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

# git support
autoload -Uz vcs_info
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst
RPROMPT=\$vcs_info_msg_0_

# autocompletion
autoload -Uz compinit
compinit -d $ZSH_COMPDUMP
_comp_options+=(globdots)

[[ -r "/usr/share/z/z.sh" ]] && source /usr/share/z/z.sh
