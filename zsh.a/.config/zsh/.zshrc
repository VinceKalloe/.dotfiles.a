#
setopt BANG_HIST                 # Treat the '!' character specially during expansion.
setopt EXTENDED_HISTORY          # Write the history file in the ":start:elapsed;command" format.
setopt INC_APPEND_HISTORY        # Write to the history file immediately, not when the shell exits.
setopt SHARE_HISTORY             # Share history between all sessions.
setopt HIST_IGNORE_DUPS          # Don't record an entry that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS      # Delete old recorded entry if new entry is a duplicate.
# setopt HIST_IGNORE_SPACE         # Don't record an entry starting with a space.

# Enable fzf
# source "/usr/share/fzf/key-bindings.zsh"
# source "/usr/share/fzf/completion.zsh"
# source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# Define prompt
autoload -Uz promptinit
promptinit
# adam1 adam2 bart bigfade clint default elite2 elite fade fire off oliver pws redhat restore suse walters zefram
prompt bart yellow green gray
#PROMPT='%F{yellow}% %f %F{green}%n %%%f %F{gray}% %f'
#PROMPT='%F{blue}%B %b%f %F{green}%n%f %F{yellow} %f %F{gray} %f '
# PROMPT='%F{blue}%B %b%f %F{green}%n%f %F{yellow} %f '
#PROMPT='%F{green}%n %%% %F{gray}% %'
#PROMPT='%B%F{cyan}? %c %f%(?:%F{green}:%F{red})? %f%b'
#PROMPT=$'%(?.%F{green}\uf303.%F{red}?%?)%f %B%F{blue}%2~%f '

autoload -Uz vcs_info
precmd() { vcs_info }
zstyle ':vcs_info:git:*' formats '%F{magenta}󰊢 %f%F{green}(%b)%r%f'
setopt PROMPT_SUBST
# PROMPT='%F{green}%*%f %F{blue}%~%f %F{red}${vcs_info_msg_0_}%f$ '
# PROMPT='%F{blue}%B %b%f %F{green}%n@%m%f %F{cyan}%~%f ${vcs_info_msg_0_} %F{yellow} %f'
NEWLINE=$'\n'
PROMPT="%F{blue}%B %b%f %F{green}%n@%m%f %F{cyan}%~%f ${vcs_info_msg_0_}...${NEWLINE}%F{yellow}  %f"

# Esc dellay = 0.2s (0.4s by default) 
export KEYTIMEOUT=20

# Explicitly set vi-mode
# bindkey -v

# Explicitky set emacs-mode
bindkey -e

# Enable autocompletion
autoload -Uz compinit
compinit

# Option 1
zstyle ':completion:*' menu select rehash true

# Option 2
# source ~/REPOs/fzf-tab/fzf-tab.zsh
# zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath'
# zstyle ':fzf-tab:complete:git-(add|diff|restore):*' fzf-preview 'git diff $word | delta'
# zstyle ':fzf-tab:complete:git-log:*' fzf-preview 'git log --color=always $word'
# zstyle ':fzf-tab:complete:git-help:*' fzf-preview 'git help $word | bat -plman --color=always'
# zstyle ':fzf-tab:complete:git-show:*' fzf-preview 'case "$group" in "commit tag") git show --color=always $word ;; *) git show --color=always $word | delta ;; esac'
# zstyle ':fzf-tab:complete:git-checkout:*' fzf-preview 'case "$group" in "modified file") git diff $word | delta ;; "recent commit object name") git show --color=always $word | delta ;; *) git log --color=always $word ;; esac'
# zstyle ':completion:*:git-checkout:*' sort false
# zstyle ':completion:*:descriptions' format '[%d]'
# zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
# zstyle ':completion:*' menu no
# zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath'
# zstyle ':fzf-tab:*' switch-group '<' '>'
# zstyle ':completion:*' list-max-items 20
#
# Key bindings
# create a zkbd compatible hash;
# to add other keys to this hash, see: man 5 terminfo
typeset -g -A key

key[Home]="${terminfo[khome]}"
key[End]="${terminfo[kend]}"
key[Insert]="${terminfo[kich1]}"
key[Backspace]="${terminfo[kbs]}"
key[Delete]="${terminfo[kdch1]}"
key[Up]="${terminfo[kcuu1]}"
key[Down]="${terminfo[kcud1]}"
key[Left]="${terminfo[kcub1]}"
key[Right]="${terminfo[kcuf1]}"
key[PageUp]="${terminfo[kpp]}"
key[PageDown]="${terminfo[knp]}"
key[Shift-Tab]="${terminfo[kcbt]}"

# setup key accordingly
[[ -n "${key[Home]}"      ]] && bindkey -- "${key[Home]}"       beginning-of-line
[[ -n "${key[End]}"       ]] && bindkey -- "${key[End]}"        end-of-line
[[ -n "${key[Insert]}"    ]] && bindkey -- "${key[Insert]}"     overwrite-mode
[[ -n "${key[Backspace]}" ]] && bindkey -- "${key[Backspace]}"  backward-delete-char
[[ -n "${key[Delete]}"    ]] && bindkey -- "${key[Delete]}"     delete-char
[[ -n "${key[Up]}"        ]] && bindkey -- "${key[Up]}"         up-line-or-history
[[ -n "${key[Down]}"      ]] && bindkey -- "${key[Down]}"       down-line-or-history
[[ -n "${key[Left]}"      ]] && bindkey -- "${key[Left]}"       backward-char
[[ -n "${key[Right]}"     ]] && bindkey -- "${key[Right]}"      forward-char
[[ -n "${key[PageUp]}"    ]] && bindkey -- "${key[PageUp]}"     beginning-of-buffer-or-history
[[ -n "${key[PageDown]}"  ]] && bindkey -- "${key[PageDown]}"   end-of-buffer-or-history
[[ -n "${key[Shift-Tab]}" ]] && bindkey -- "${key[Shift-Tab]}"  reverse-menu-complete

# Finally, make sure the terminal is in application mode, when zle is
# active. Only then are the values from $terminfo valid.
if (( ${+terminfo[smkx]} && ${+terminfo[rmkx]} )); then
	autoload -Uz add-zle-hook-widget
	function zle_application_mode_start { echoti smkx }
	function zle_application_mode_stop { echoti rmkx }
	add-zle-hook-widget -Uz zle-line-init zle_application_mode_start
	add-zle-hook-widget -Uz zle-line-finish zle_application_mode_stop
fi

# History search
autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

[[ -n "${key[Up]}"   ]] && bindkey -- "${key[Up]}"   up-line-or-beginning-search
[[ -n "${key[Down]}" ]] && bindkey -- "${key[Down]}" down-line-or-beginning-search

# Modifiers
# for Ctrl+Left to move to the beginning of the previous word and Ctrl+Right to move to the beginning of the next word:
key[Control-Left]="${terminfo[kLFT5]}"
key[Control-Right]="${terminfo[kRIT5]}"

[[ -n "${key[Control-Left]}"  ]] && bindkey -- "${key[Control-Left]}"  backward-word
[[ -n "${key[Control-Right]}" ]] && bindkey -- "${key[Control-Right]}" forward-word


# # Resetting the broken terminal with escape sequences
# autoload -Uz add-zsh-hook
#
# function reset_broken_terminal () {
# 	printf '%b' '\e[0m\e(B\e)0\017\e[?5l\e7\e[0;0r\e8'
# }
#
# add-zsh-hook -Uz precmd reset_broken_terminal
#
# # Dirstack
# autoload -Uz add-zsh-hook
#
# DIRSTACKFILE="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/dirs"
# if [[ -f "$DIRSTACKFILE" ]] && (( ${#dirstack} == 0 )); then
# 	dirstack=("${(@f)"$(< "$DIRSTACKFILE")"}")
# 	[[ -d "${dirstack[1]}" ]] && cd -- "${dirstack[1]}"
# fi
# chpwd_dirstack() {
# 	print -l -- "$PWD" "${(u)dirstack[@]}" > "$DIRSTACKFILE"
# }
# add-zsh-hook -Uz chpwd chpwd_dirstack
#
# DIRSTACKSIZE='20'

setopt AUTO_PUSHD PUSHD_SILENT PUSHD_TO_HOME

## Remove duplicate entries
setopt PUSHD_IGNORE_DUPS

## This reverts the +/- operators.
setopt PUSHD_MINUS

# Autosuggestions and highlighting like in fish
# source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
bindkey '^f'  forward-word 
bindkey '^b'  backward-word         


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
# Enable fzf
# source "/usr/share/fzf/key-bindings.zsh"
# source "/usr/share/fzf/completion.zsh"
#
# Autosuggestions and highlighting like in fish
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

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

# ----- Some nvims -----
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









