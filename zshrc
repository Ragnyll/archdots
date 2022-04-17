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
export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -g ""'

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

source $HOME/.aliases
source $HOME/.config/skim/completion.zsh
source $HOME/.config/skim/key-bindings.zsh

# zoptions
setopt rmstarsilent
setopt histignoredups

# key binds
bindkey '^ ' autosuggest-accept
eval "$(oh-my-posh init zsh --config ~/.config/prompts/v_sitecorian.omp.json)"
