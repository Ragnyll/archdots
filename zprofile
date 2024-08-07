
#
# Browser
#
#
# Editors
#

export EDITOR='nvim'
export VISUAL='nvim'
export PAGER='bat'
export BROWSER='firefox'

#
# Language
#

if [[ -z "$LANG" ]]; then
  export LANG='en_US.UTF-8'
fi

#
# Paths
#

# Ensure path arrays do not contain duplicates.
typeset -gU cdpath fpath mailpath path

# Set the list of directories that cd searches.
# cdpath=(
#   $cdpath
# )

# Set the list of directories that Zsh searches for programs.
path=(
  /usr/local/{bin,sbin}
  $HOME/.cargo/bin:$PATH
  $HOME/.local/bin
  $HOME/.local/lib/python3.9/site-packages # this doesnt seem right
  $HOME/bin/
  $HOME/.zfunc
  $path
)

#
# Less
#

# Set the default Less options.
# Mouse-wheel scrolling has been disabled by -X (disable screen clearing).
# Remove -X and -F (exit if the content fits on one screen) to enable it.
export LESS='-F -g -i -M -R -S -w -X -z-4'

# Set the Less input preprocessor.
# Try both `lesspipe` and `lesspipe.sh` as either might exist on a system.
if (( $#commands[(i)lesspipe(|.sh)] )); then
  export LESSOPEN="| /usr/bin/env $commands[(i)lesspipe(|.sh)] %s 2>&-"
fi


#
# Stop java gui applications from being screwy
#
export _JAVA_AWT_WM_NONREPARENTING=1
