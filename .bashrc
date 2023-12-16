# /etc/skel/.bashrc
#
# This file is sourced by all *interactive* bash shells on startup,
# including some apparently interactive shells such as scp and rcp
# that can't tolerate any output.  So make sure this doesn't display
# anything or bad things will happen !


# Test for an interactive shell.  There is no need to set anything
# past this point for scp and rcp, and it's important to refrain from
# outputting anything in those cases.
if [[ $- != *i* ]] ; then
    # Shell is non-interactive.  Be done now!
    return
fi


# Put your fun stuff here.

# Bash prompt configuration
# Without git
# PS1='\[\e[38;5;142m\]╭──── \[\e[38;5;107m\]\w\n\[\e[38;5;142m\]╰─ ❱ \[\e[0m\]'

# With git
#PS1='\[\e[38;5;142m\]╭──── \[\e[38;5;108;2m\]$(git branch 2>/dev/null | grep '"'"'*'"'"' | colrm 1 2) \[\e[0;38;5;107m\]\w\n\[\e[38;5;142m\]╰─ ❱ \[\e[0m\]'

# Virtual env
PS1='\[\e[38;5;142m\]╭──── \[\e[38;5;108;2m\]$(git branch 2>/dev/null | grep '"'"'*'"'"' | colrm 1 2) \[\e[0;38;5;107m\]\w \[\e[38;5;172m\]`basename "$VIRTUAL_ENV"`\n\[\e[38;5;142m\]╰─ ❱ \[\e[0m\]'

PS2='> '

# Run tmux upon every shell login
if [ -x "$(command -v tmux)" ] && [ -n "${DISPLAY}" ] && [ -z "${TMUX}" ]; then
    exec tmux new-session -A -s ${USER} >/dev/null 2>&1
fi

# Set history formatting and ignore duplicates
HISTTIMEFORMAT="%F %T "
HISTCONTROL=ignoredups

# Set the number of lines in active historyl and set the number of lines saved in Bash history
HISTSIZE=2000
HISTFILESIZE=2000

# Add vim-like commands to Bash
set -o vi

# Set vim as a default editor
export VISUAL=vim
export EDITOR="$VISUAL"

# If there are multiple matches for completion, Tab should cycle through them
bind 'TAB:menu-complete'
# And Shift-Tab should cycle backwards
bind '"\e[Z": menu-complete-backward'

# Display a list of the matching files
bind "set show-all-if-ambiguous on"

# Perform partial (common) completion on the first Tab press, only start
# cycling full results on the second Tab press (from bash version 5)
bind "set menu-complete-display-prefix on"

# Disaple prompt mangling
export VIRTUAL_ENV_DISABLE_PROMPT=1
alias config='/usr/bin/git --git-dir=/home/larry/.cfg/ --work-tree=/home/larry'
alias vim='nvim'
