###
# Arch Linux zshrc conf
###
# Source Prezto.

if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# set the theme terminal theme correctly
~/bin/wal_setter.sh $(head -n 1 ~/.config/wallpaper)

optimus-manager --print-mode | grep 'nvidia' > /dev/null && neofetch

export EDITOR=nvim

# use vim bindings in prompmt
set -o vi

# git configurations
export LESS="-R" # fixes colouring on git graph

# colorize less
export LESS='-R'

# enable fuzzyfind
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -g ""'

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

source $HOME/.aliases

# keep installed packages in sync
yay_installed >! ~/.dotfiles/install.txt

# zoptions
setopt rmstarsilent
setopt histignoredups
