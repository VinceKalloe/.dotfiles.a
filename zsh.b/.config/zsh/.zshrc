
bindkey -v    # vi mode

source $HOME/.aliases  # aliases

setopt HIST_SAVE_NO_DUPS          # Do not write a duplicate event to the history file.
unsetopt HIST_SAVE_NO_DUPS        # Write a duplicate event to the history file

autoload 
fpath=($ZDOTDIR $fpath)
autoload -Uz prompt_purification_setup && prompt_purification_setup

autoload -U compinit; compinit
_comp_options+=(globdots) # With hidden files
source $ZDOTDIR/completion.zsh
