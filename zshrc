###
# Arch Linux zshrc conf
###

if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

export EDITOR=nvim

# use vim bindings in prompmt
set -o vi

# git configurations
export LESS="-R" # fixes colouring on git graph

# enable fuzzyfind
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

source $HOME/.aliases

# zoptions
setopt rmstarsilent
setopt histignoredups

# key binds
bindkey '^n' autosuggest-accept
bindkey '^R' history-incremental-search-backward
source <(fzf --zsh)
eval "$(oh-my-posh init zsh --config ~/.config/prompts/bubblesextra.omp.json)"

# pnpm
export PNPM_HOME="/home/ragnyll/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

HISTFILE=~/.zhistory
HISTSIZE=10000
SAVEHIST=10000

# Share history in every terminal session
setopt SHARE_HISTORY

