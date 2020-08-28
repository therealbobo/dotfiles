
### SOURCES ###{{{
source "$XDG_CONFIG_HOME/zsh/aliases"
source "$XDG_CONFIG_HOME/zsh/vars.zsh"
###}}}

PROMPT='%(?.%F{green}√.%F{red}✗ %?)%f' # error handling
PROMPT+=' %F{green}%B%n@%M%b%f:'       # username@hostname
PROMPT+='%F{blue}%2~%f %# '          # pwd

COMPLETION_WAITING_DOTS="true"

# TODO mv histfile
[ ! -f "$XDG_DATA_HOME"/vim/histfile ] && touch "$XDG_DATA_HOME"/vim/histfile
HISTFILE="$XDG_DATA_HOME"/vim/histfile
HISTSIZE=1000
SAVEHIST=1000
setopt autocd notify
bindkey -v
bindkey '^R' history-incremental-search-backward

# git support
autoload -Uz vcs_info
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst
RPROMPT=\$vcs_info_msg_0_
zstyle ':vcs_info:git:*' formats '%F{240}(%b)%r%f'
zstyle ':vcs_info:*' enable git

export ZSH_COMPDUMP="$XDG_CACHE_HOME/zsh/zcompdump-$ZSH_VERSION"
zstyle :compinstall filename "$HOME/.zshrc"
zstyle ':completion:*' menu select
autoload -Uz compinit
compinit -d $ZSH_COMPDUMP

export KEYTIMEOUT=1

