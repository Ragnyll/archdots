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

# searches for a string $1 in all directories recursively $2
# and outputs those file names along with the line
alias stringSearch='grep -rnw $1 -e $2'

# other random aliases
alias copy='xclip'
alias tarball='tar cvf'
alias detarball='tar xzf'

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
