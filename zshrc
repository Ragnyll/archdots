###
# Arch Linux zshrc conf
###
# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

export EDITOR=nvim
alias vim='nvim'

# use vim bindings in prompmt
set -o vi

# git configurations
export LESS="-R" # fixes colouring on git graph
alias conflicts='git diff --name-only --deff-filter=U'
alias gti='git' # i suck at typing
alias sl='ls'

# other random aliases
alias tarball='tar cvf'
alias detarball='tar xzf'
alias brightness='xrandr --verbose | grep -m 1 -i brightness | cut -f2 -d " "'

# sh functions
function vpn_connect() { 
	sudo systemctl start nordvpnd.service
	nordvpn login
	nordvpn connect
}

function vpn_disconnect() {
	nordvpn disconnect
	nordvpn logout
	sudo systemctl stop nordvpn
}

# colorize less
export LESS='-R'

# enable fuzzyfind
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

neofetch
