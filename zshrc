###
# Arch Linux zshrc conf
###
# Source Prezto.

if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

export EDITOR=nvim
alias vim='nvim'
alias vranger='nvim .'

# use vim bindings in prompmt
set -o vi

# git configurations
export LESS="-R" # fixes colouring on git graph
alias conflicts='git diff --name-only --deff-filter=U'
alias gti='git' # i suck at typing

# other random aliases
alias sl='ls'
alias virus_scan='sudo freshclam && sudo clamscan -r --bell -i /'
alias jekyll_server='bundle exec jekyll serve'
alias gpgrun='gpg --decrypt $1 | sh'

alias tor='~/Applications/tor-browser_en-US/Browser/start-tor-browser' 

# colorize less
export LESS='-R'

# enable fuzzyfind
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -g ""'

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

# ready to go
neofetch
