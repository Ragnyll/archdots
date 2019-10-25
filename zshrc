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
alias tarball='tar cvf'
alias detarball='tar xzf'
alias virus_scan='sudo freshclam && sudo clamscan -r --bell -i /'
alias brightness='xrandr --verbose | grep -m 1 -i brightness | cut -f2 -d " "'
alias tor='~/bin/tor-browser_en-US/Browser/start-tor-browser' 

# colorize less
export LESS='-R'

# enable fuzzyfind
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

neofetch

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
