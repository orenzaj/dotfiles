# Misc
if [[ $(uname -s) == Linux  ]]; then
    alias ls='ls --group-directories-first --color=auto'
else
    alias ls='gls --group-directories-first --color=auto'
fi

alias pyclean='find . -type f -name "*.py[co]" -exec rm -f \{\} \;'
alias speedtest="curl -s https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py | python -"
alias whatsmyip="dig +short myip.opendns.com @resolver1.opendns.com"
alias xclip-grab="xclip -i -selection clipboard"

# Git
alias gs="git status -sb"
alias gits="gs | grep '^M ' | awk '{print \$2}'"
alias gitd="gs | grep -E \"D\\s\""

# Untracked
alias gitu="gs | grep '?? '"
alias gitau="gitu | awk '{print \"git add \"\$2}' | sh"
alias gitcou="gitu | awk '{print \"git checkout \-\- \"\$2}' | sh"
alias gitrmu="gitu | awk '{print \"rm -rf \"\$2}' | sh"

# Both Modified
alias gitb="gs | grep \"AA\|MM\|UU\""
alias gitab="gitb | awk '{print \"git add \"\$2}' | sh"
alias gitrmb="gitb | awk '{print \"rm -rf \"\$2}' | sh"
alias gitcob="gitb | awk '{print \"git checkout \"\$2}' | sh"

# Modified
alias gitm="gs | grep ' M '"
alias gitam="gitm | awk '{print \"git add \"\$2}' | sh"
alias gitcom="gitm | awk '{print \"git checkout \"\$2}' | sh"
alias gitrmm="gitm | awk '{print \"rm \"\$2}' | sh"
alias gitsm="gs | grep 'M ' | awk '{print \"git reset HEAD \"\$2}' | sh"

# All
alias gitaa="gs | grep -v \# | awk '{print \"git add \"\$2}' | sh"
alias gitcoa="gs | grep -v \# | awk '{print \"git checkout \-\- \"\$2}' | sh"
alias gitrma="gs | grep -v \# | awk '{print \"rm\"\$2}' | sh"
alias gitrmd="gitd | awk '{print \"git rm \"\$2}' | sh"

# Diffs
alias gitds="git diff --staged"
alias gitmig="gs | grep 'migrations' | awk '{print \$2}'"

# Branches
alias gb="git for-each-ref --sort=committerdate refs/heads/ --format='%(committerdate:short) %(refname:short)'"
alias gcm="git checkout master"
alias gcb="git checkout -b"

# Push
alias gpu="git push -u origin HEAD"
alias gpb='f(){ gcb && gitam && git commit {"$@"} && gpu; unset -f f; }; f'

# Stash
alias gsl="git stash list"
alias gss="git stash save"
alias gsa='f(){ git stash apply stash@{"$@"};  unset -f f; }; f'

# Trello
alias trellopath="cd ~/git/trello/src/"
alias trelloenv="trellopath && source ../trello-env/bin/activate"

# Pyenv Deactivate
function deactivate_env(){
    if [ -z $PYENV_VERSION ]; then
        eval deactivate;
    else
        eval pyenv_deactivate;
    fi
}
alias pyenv_deactivate="source deactivate"
alias deactivate="deactivate_env"

# Sites
function sitesenv(){
    if [ -z $PYENV_VERSION ]; then
        eval sitesactivate;
    else
        eval sitespath;
    fi
}
function sitesupdate(){
    eval sitesmake;
    eval sitesmigrate;
}
alias sitesbackend="sitespath && cd backend"
alias sitesfrontend="sitespath && cd frontend"
alias sitespath="cd ~/git/Django/src/sites"
alias sitesactivate="pyenv activate sites-env && sitespath"
alias sitesserver="sitesenv && python manage.py runserver 8081"
alias sitesmigrate="sitesenv && python manage.py migrate"
alias sitesmake="sitesenv && python manage.py makemigrations"
alias siteskill="lsof -i:8080 | grep [p]ython | awk '{print \"kill \"\$2}' | sh"
alias sitesshell="sitesenv && python manage.py shell_plus"
