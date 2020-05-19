# Dockers
alias startdockers="docker start dev-centerprise-nginx dev-centerprise-sentry dev-centerprise-cms dev-centerprise-cms-login"
alias stopdockers="docker ps -q | awk '{print \"docker stop \" \$1}' | sh"

# Celery Debugger
alias rdb="telnet localhost 6900"

# Misc
# Disables the extra env variable printing.
if [[ $(uname -s) == Linux  ]]; then
    alias ls='ls --group-directories-first --color=auto'
else
    alias ls='gls --group-directories-first --color=auto'
fi
if [ -x "$(which nvim)"  ]; then
    alias vim='nvim'
fi
alias pyclean='find . -type f -name "*.py[co]" -exec rm -f \{\} \;'
alias speedtest="curl -s https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py | python -"
alias whatsmyextip="dig +short myip.opendns.com @resolver1.opendns.com | awk '{print \"external: \"\$1}'"
alias whatsmylocalip="ifconfig | grep 'inet ' | awk '{print \"local: \"\$2}' | cut -f1 -d'/'"
alias whatsmyip="whatsmylocalip && whatsmyextip"
alias whatsmyip4="dig @resolver1.opendns.com A myip.opendns.com +short -4"
alias whatsmyip6="dig @resolver1.opendns.com A myip.opendns.com +short -6"
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

# All
alias gitaa="gs | grep -v \# | awk '{print \"git add \"\$2}' | sh"
alias gitcoa="gs | grep -v \# | awk '{print \"git checkout \-\- \"\$2}' | sh"
alias gitrma="gs | grep -v \# | awk '{print \"rm\"\$2}' | sh"
alias gitrmd="gitd | awk '{print \"git rm \"\$2}' | sh"

# Diffs
alias gitds="git diff --staged"
alias gitmig="gs | grep 'migrations' | awk '{print \$2}'"

# Trello
alias trellopath="cd ~/git/trello/src/"
alias trelloenv="trellopath && source ../trello-env/bin/activate"

# Aptcast
function aptcastdevupdate(){
    eval aptcastpath
    eval aptcastfreshinstall
}
function aptcastandroidbuild(){
    ionic cordova build android \
        --developmentTeam="Apartments24-7.com" \
        --codeSignIdentity="Android Developer" \
        --profile dev
}
function aptcastiosbuild(){
    ionic cordova build ios \
        --developmentTeam="Apartments24-7.com" \
        --codeSignIdentity="iPhone Developer" \
        --profile dev
}
function aptcastfixplatforms(){
    ionic platform rm android
    ionic platform rm ios
    ionic plugin rm cordova-plugin-firebase
    ionic platform add android
    ionic platform add ios
    ionic plugin add cordova-plugin-firebase
}
alias aptcastpath="cd ~/git/ResidentPlus/"
alias aptcastfreshinstall="nvm install-latest-npm && npm i -g ionic cordova cordova-res"
alias aptcastbuildandroid="ionic cordova build android"
alias aptcastrebuildandroid="ionic cordova platform remove android && ionic cordova platform add android@latest"
alias aptcastbuildios="ionic cordova build ios"
alias aptcastrebuildios="ionic cordova platform remove ios && ionic cordova platform add ios@latest"
