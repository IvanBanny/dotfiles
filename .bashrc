# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=100000
HISTFILESIZE=50000
HISTTIMEFORMAT="%F %T  "

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

# Aperture theme colors (truecolor)
#   fg/orange     #FC9505  38;2;252;149;5
#   link/blue     #6FABFF  38;2;111;171;255
#   positive/grn  #6FDB88  38;2;111;219;136
#   neutral/gold  #EEBB44  38;2;238;187;68
#   negative/red  #FF6F6F  38;2;255;111;111
#   inactive/gry  #8C8C8C  38;2;140;140;140
if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[1;38;2;252;149;5m\]\u@\h\[\033[0m\]\[\033[38;2;140;140;140m\]:\[\033[0m\]\[\033[38;2;111;171;255m\]\w\[\033[0m\]\[\033[38;2;238;187;68m\]\$\[\033[0m\] '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

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

# colored GCC warnings and errors (aperture palette)
export GCC_COLORS='error=01;38;2;255;111;111:warning=01;38;2;238;187;68:note=01;38;2;111;171;255:caret=01;38;2;111;219;136:locus=01;38;2;252;149;5:quote=01;38;2;252;149;5'

# less colors (aperture)
export LESS='-R'
export LESS_TERMCAP_mb=$'\033[1;38;2;255;111;111m'
export LESS_TERMCAP_md=$'\033[1;38;2;252;149;5m'
export LESS_TERMCAP_me=$'\033[0m'
export LESS_TERMCAP_se=$'\033[0m'
export LESS_TERMCAP_so=$'\033[1;38;2;20;11;5;48;2;238;187;68m'
export LESS_TERMCAP_ue=$'\033[0m'
export LESS_TERMCAP_us=$'\033[4;38;2;111;171;255m'

# grep colors (aperture)
export GREP_COLORS='ms=01;38;2;238;187;68:mc=01;38;2;238;187;68:sl=:cx=:fn=38;2;111;171;255:ln=38;2;140;140;140:bn=38;2;140;140;140:se=38;2;140;140;140'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -AC'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# Read .rsync-target from current or parent dirs
_rsync_target() {
    local dir="$PWD"
    while [[ "$dir" != "/" ]]; do
        if [[ -f "$dir/.rsync-target" ]]; then
            echo "$dir" "$(head -1 "$dir/.rsync-target")"
            return 0
        fi
        dir="$(dirname "$dir")"
    done
    echo "No .rsync-target found" >&2
    return 1
}

rpush() {
    read -r root target < <(_rsync_target) || return 1
    rsync -az --filter=':- .rsync-ignore' \
        --exclude='.rsync-target' --exclude='.rsync-ignore' \
        --exclude='.git' --exclude='.gitignore' \
        "$root/" "$target"
}

rpull() {
    read -r root target < <(_rsync_target) || return 1
    rsync -az --filter=':- .rsync-ignore' \
        --exclude='.rsync-target' --exclude='.rsync-ignore' \
        --exclude='.git' --exclude='.gitignore' \
        "$target/" "$root"
}

mvd() { mv ~/Downloads/"$(ls -t ~/Downloads | head -1)" .; }

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/ivan/miniconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/ivan/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/home/ivan/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/ivan/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

alias vim="nvim"
export EDITOR="nvim"
export VISUAL="nvim"

alias dot='git --git-dir=$HOME/.dotfiles --work-tree=$HOME'

yoink() { xclip -selection clipboard < "$1"; }


export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
