# TESTING
# SOURCE FILES
if [ -f ~/.git-completion.bash ]; then
    . ~/.git-completion.bash
fi

if [ -f ~/.git-prompt.sh ]; then
    . ~/.git-prompt.sh
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
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:"/usr/local/lib"
export CPPFLAGS="-P"

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
