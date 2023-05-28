###
# Arch Linux zshrc conf
###
# Source Prezto.

if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# set the theme terminal theme correctly
# needed to see command hinting against background
~/bin/wal_setter.sh $(head -n 2 ~/.config/wallpaper)

export EDITOR=nvim

# use vim bindings in prompmt
set -o vi

# git configurations
export LESS="-R" # fixes colouring on git graph

# enable fuzzyfind
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

source $HOME/.aliases
source $HOME/.config/skim/completion.zsh
source $HOME/.config/skim/key-bindings.zsh

# zoptions
setopt rmstarsilent
setopt histignoredups

# key binds
bindkey '^n' autosuggest-accept
eval "$(oh-my-posh init zsh --config ~/.config/prompts/blue-owl.omp.json)"
