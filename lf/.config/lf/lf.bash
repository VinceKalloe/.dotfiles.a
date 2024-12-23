# Change working dir in shell to last dir in lf on exit (adapted from ranger).
#
# You need to either copy the content of this file to your shell rc file
# (e.g. ~/.bashrc) or source this file directly:
#
#     LFCD="/path/to/lfcd.sh"
#     if [ -f "$LFCD" ]; then
#         source "$LFCD"
#     fi
#
# You may also like to assign a key (Ctrl-O) to this command:
#
#     bind '"\C-o":"lfcd\C-m"'  # bash
#     bindkey -s '^o' 'lfcd\n'  # zsh
#

#lfcd () {
#    # `command` is needed in case `lfcd` is aliased to `lf`
#    cd "$(command lf -print-last-dir "$@")"
#}

lf() {
   export LF_CD_FILE="/var/tmp/.lfcd-$$"
   command lf "$@"
   if [ -s "$LF_CD_FILE" ]; then
       local DIR="$(realpath -- "$(cat -- "$LF_CD_FILE")")"
       if [ "$DIR" != "$PWD" ]; then
           printf 'cd to %s\n' "$DIR"
           cd "$DIR"
       fi
       rm "$LF_CD_FILE"
   fi
   unset LF_CD_FILE
}
