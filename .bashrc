# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

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
HISTSIZE=1000
HISTFILESIZE=2000

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
#force_color_prompt=yes

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

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
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

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ls='ls --color=auto --group-directories-first'
alias ll='ls -alF'
alias la='ls -A'
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

# PATHS
export PATH=$PATH:/usr/local/go/bin
export GOPATH=$HOME/go
export GOBIN=$GOPATH/bin
export PATH=$PATH:$GOBIN
export GIT_PROMPT_ONLY_IN_REPO=1
export GIT_PS1_SHOWCOLORHINTS=true
export GIT_PS1_SHOWDIRTYSTATE=1
export VIRTUAL_ENV_DISABLE_PROMPT=1

# export PATH=$PATH:/usr/lib/rabbitmq/bin
# export RABBITMQ_CONFIG_FILE=/home/jorenza/config/rabbitmq
# export RABBITMQ_SERVER_ERL_ARGS="-setcookie rabbit"
# export RABBITMQ_CTL_ERL_ARGS="-setcookie rabbit"


# COLORS
bold=$(tput bold)
normal=$(tput sgr0)
reset=$(tput setaf 0)
red=$(tput setaf 1)
green=$(tput setaf 2)
orange=$(tput setaf 3)
blue=$(tput setaf 4)
purple=$(tput setaf 5)
turquoise=$(tput setaf 6)
grey=$(tput setaf 7)

# PROMPT
topborder="\n\[${bold}\]\[${orange}\]\342\224\215"
mainprompt="[\[${normal}\]\[${red}\]\u@\H: \w\[${bold}\]\[${orange}\]]\[${normal}\]"
bottomborder="\n\[${bold}\]\[${orange}\]\342\224\225▶"
bottomprompt=" \[${normal}\]"

ve() {
    if [ ${VIRTUAL_ENV}  ] ; then
        printf "${bold}${orange}[${normal}${turquoise}`basename \"${VIRTUAL_ENV}\"`${bold}${orange}]${normal}"
    fi
}

gb(){
    __git_ps1 "[%s]" | sed -e "s/^\[/$(printf ${bold}${orange}\[${normal}${green})/" -e "s/]/$(printf ${bold}${orange}]${normal})/"
}

PS1=${topborder}${mainprompt}
PS1+='$(ve)'
PS1+='$(gb)'
PS1+=${bottomborder}${bottomprompt}
export PS1

alias pyclean='find . -type f -name "*.py[co]" -exec rm -f \{\} \;'

alias venvcms=". ~/git/cms/cms-env/bin/activate"
alias runcms="python ~/git/cms/src/247/manage.py runserver --insecure"
alias migratecms="python ~/git/cms/src/247/manage.py migrate --noinput"
alias shellcms="python ~/git/cms/src/247/manage.py shell_plus"
alias celerycms="cd ~/git/cms/src/247 && celery -A celery_init worker --loglevel=debug"

alias startdockers="docker start dev-centerprise-nginx dev-centerprise-sentry dev-centerprise-cms"
alias venvcent=". ~/git/centerprise/cent-env/bin/activate"

alias venvsec=". ~/git/secureapps/secure-apps-env/bin/activate"
alias migratesec="python ~/secureapps/manage.py migrate --noinput"
alias runsec="python ~/secureapps/manage.py runserver 0.0.0.0:8080 --insecure"
alias celerysec="cd ~/git/secureapps/src/ && celery -A celery_init worker --loglevel=debug"

alias rdb="telnet localhost 6900"
