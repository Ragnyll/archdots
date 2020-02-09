###
# Arch Linux zshrc conf
###
# Source Prezto.

if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

neofetch

export EDITOR=nvim
alias vim='nvim -O'
alias vranger='nvim .'

# use vim bindings in prompmt
set -o vi

# git configurations
export LESS="-R" # fixes colouring on git graph
alias conflicts='git diff --name-only --diff-filter=U'
alias gti='git' # i suck at typing

# other random aliases
alias sl='ls'
alias virus_scan='sudo freshclam && sudo clamscan -r --bell -i /'
alias gpgrun='gpg --decrypt $1 | sh'
alias battery='upower -i /org/freedesktop/UPower/devices/battery_BAT0'
alias tor='~/Applications/tor-browser_en-US/Browser/start-tor-browser'
alias mutt='neomutt'

# colorize less
export LESS='-R'

# enable fuzzyfind
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -g ""'

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
