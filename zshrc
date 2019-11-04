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

function kali_up() {
	systemctl start docker.service
	sudo docker run -t -i kalilinux/kali-rolling /bin/bash
}

alias kali_down='systemctl stop docker.service'

# ready to go
neofetch

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
