export GIT_PROMPT_ONLY_IN_REPO=1
export GIT_PS1_SHOWCOLORHINTS=true
export GIT_PS1_SHOWDIRTYSTATE=1
export VIRTUAL_ENV_DISABLE_PROMPT=1
export RABBITMQ_CONFIG_FILE=/home/jorenza/.config/rabbitmq
export RABBITMQ_SERVER_ERL_ARGS="-setcookie rabbit"
export RABBITMQ_CTL_ERL_ARGS="-setcookie rabbit"

# SOURCE FILES"
source ~/.git-completion.bash
source ~/.git-prompt.sh

# PATHS
export GOPATH="$HOME/go"
export GOBIN="$GOPATH/bin"
export VIMRC="$HOME/.vimrc"
export PATH="$HOME/.local/bin:$PATH"
export PATH="/usr/sbin:$PATH"
export PATH="/usr/local/go/bin:$PATH"
export PATH="/usr/lib/rabbitmq/bin:$PATH"
export PATH="$PATH:$GOPATH/bin"

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
mainprompt="[\[${normal}\]\[${red}\]\u: \w\[${bold}\]\[${orange}\]]\[${normal}\]"
bottomborder="\n\[${bold}\]\[${orange}\]\342\224\225▶"
bottomprompt=" \[${normal}\]"

ve() {   
    if [ ${VIRTUAL_ENV} ] ; then
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

# NAMED PATHS 
SECAPP="$HOME/Dev/secureapps/src"
CMS="$HOME/Dev/cms/src"
GOSRC="$GOPATH/src"

# ALIASES
alias ls="ls --color=auto --group-directories-first"

# CMS
alias venvcms=". $HOME/cms/env/bin/activate"
alias runcms="python $HOME/cms/src/247/manage.py runserver"
alias shellcms="python $HOME/cms/src/247/manage.py shell_plus"
alias migratecms="python $HOME/cms/src/247/manage.py migrate --noinput"
alias celerycms="cd $HOME/cms/src/247 && celery -A celery_init worker -c1 --loglevel=debug"

# SECURE APPS
alias venvsec=". $HOME/secureapps/env/bin/activate"
alias runsec="python $HOME/secureapps/src/manage.py runserver"
alias shellsec="python $HOME/secureapps/src/manage.py shell_plus"
alias migratesec="python $HOME/secureapps/src/manage.py migrate --noinput"
alias celerysec="cd $HOME/secureapps/src && celery -A celery_init worker -c1 --loglevel=debug"


# TILIX
if [ $TILIX_ID ] || [ $VTE_VERSION ] ; then source /etc/profile.d/vte.sh; fi # Ubuntu Budgie END
