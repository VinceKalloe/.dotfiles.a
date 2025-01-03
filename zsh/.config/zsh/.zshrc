# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Lines configured by zsh-newuser-install
# HISTFILE=~/.zhistfile
# HISTSIZE=10000
# SAVEHIST=10000
# setopt share_history
# setopt hist_expire_dups_first
# setopt hist_ignore_dups
# setopt hist_verify

# Default editor
# export EDITOR=nvim

# completion using arrow keys (based on history)
# bindkey '^[[A' history-search-backward
# bindkey '^[[B' history-search-forward

bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/iam/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme

# Aliases
# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='exa -lahbgF --git --icons'
#alias bat='batcat'
alias sudo='sudo '

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# ---- Eza (better ls) -----
alias ls="eza --color=always --long --git --no-filesize --icons=always --no-time --no-user --no-permissions"
alias l='exa -lahbgF --git --icons'
alias ll='ls -alF'
alias la='ls -A'

# ---- Zoxide (better cd) ----
eval "$(zoxide init zsh)"
alias cd="z"

# Yazi change CWD
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

# ---- FZF -----
# Set up fzf key bindings and fuzzy completion
eval "$(fzf --zsh)"

# -- Use fd instead of fzf --
export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"

# Use fd (https://github.com/sharkdp/fd) for listing path candidates.
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.
_fzf_compgen_path() {
  fd --hidden --exclude .git . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type=d --hidden --exclude .git . "$1"
}

show_file_or_dir_preview="if [ -d {} ]; then eza --tree --color=always {} | head -200; else bat -n --color=always --line-range :500 {}; fi"

export FZF_CTRL_T_OPTS="--preview '$show_file_or_dir_preview'"
export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"

# Advanced customization of fzf options via _fzf_comprun function
# - The first argument to the function is the name of the command.
# - You should make sure to pass the rest of the arguments to fzf.
_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)           fzf --preview 'eza --tree --color=always {} | head -200' "$@" ;;
    export|unset) fzf --preview "eval 'echo ${}'"         "$@" ;;
    ssh)          fzf --preview 'dig {}'                   "$@" ;;
    *)            fzf --preview "$show_file_or_dir_preview" "$@" ;;
  esac
}

# ----- Bat (better cat) -----
export BAT_THEME=gruvbox_dark

# thefuck alias
eval $(thefuck --alias)
eval $(thefuck --alias fk)

# ---- Zoxide (better cd) ----
eval "$(zoxide init zsh)"
alias cd="z"

# for i in {0..255}; do print -Pn "%K{$i}  %k%F{$i}${(l:3::0:)i}%f " ${${(M)$((i%6)):#3}:+$'\n'}; done

# Aliases
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias sudo='sudo '
alias ip='ip -c '

# -- Some nvims
# NeoVIM multiply configs
alias nl="NVIM_APPNAME=LazyVim nvim"
alias nk="NVIM_APPNAME=kickstart nvim"
alias nc="NVIM_APPNAME=NvChad nvim"

# Default is LazyVim
export NVIM_APPNAME="nvim.lv"

function nvims() {
  items=("default -> ~/.config/nvim" "kickstart -> ~/.config/nvim.ks" "LazyVim -> ~/.config/nvim.lv" "NvChad -> ~/.config/nvim.ch")
  config=$(printf "%s\n" "${items[@]}" | fzf --prompt="  Neovim Config > " --height=~50% --layout=reverse --border --exit-0)
  echo $config
  if [[ -z $config ]]; then
    echo "Nothing selected"
    return 0
  elif [[ $config == "default" ]]; then
    #config=""
    config="LazyVim -> ~/.config/nvim.lv" 
  fi
  # NVIM_APPNAME=$config nvim $@
  NVIM_APPNAME=$(echo $config | cut -d' ' -f 3 | cut -d '/' -f 3)
  # echo $NVIM_APPNAME
  NVIM_APPNAME=$(echo $config | cut -d' ' -f 3 | cut -d '/' -f 3) nvim $@
  # nvim $@
}

bindkey -s ^a "nvims\n"


