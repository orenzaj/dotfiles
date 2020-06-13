# Disables the extra env variable printing.
if [[ $(uname -s) == Linux  ]]; then
    alias ls='ls --group-directories-first --color=auto'
else
    alias ls='gls --group-directories-first --color=auto'
fi
if [ -x "$(which nvim)"  ]; then
    alias vim='nvim'
fi

# Misc
alias pyclean='find . -type f -name "*.py[co]" -exec rm -f \{\} \;'
alias speedtest="curl -s https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py | python -"
alias whatsmyextip="dig +short myip.opendns.com @resolver1.opendns.com | awk '{print \"external: \"\$1}'"
alias whatsmylocalip="ifconfig | grep 'inet ' | awk '{print \"local: \"\$2}' | cut -f1 -d'/'"
alias whatsmyip="whatsmylocalip && whatsmyextip"
alias whatsmyip4="dig @resolver1.opendns.com A myip.opendns.com +short -4"
alias whatsmyip6="dig @resolver1.opendns.com A myip.opendns.com +short -6"
alias xclip-grab="xclip -i -selection clipboard"

# Trello
alias trellopath="cd ~/git/trello/src/"
alias trelloenv="trellopath && source ../trello-env/bin/activate"

# Aptcast
function aptcastdevupdate(){
    eval aptcastpath
    eval aptcastfreshinstall
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
alias aptcastfreshinstall="nvm install-latest-npm && npm i -g ionic"
alias aptcastbuildandroid="ionic cordova build android"
alias aptcastrebuildandroid="ionic cordova platform remove android && ionic cordova platform add android@latest"
alias aptcastbuildios="ionic cordova build ios"
alias aptcastrebuildios="ionic cordova platform remove ios && ionic cordova platform add ios@latest"


# Resident Plus
function RPBrowserBuild(){
    ionic build
    ionic serve
}

function RPAndroidBuild(){
    ionic repair
    ionic cap sync
    npx cap update android
    npx cap copy android
    npx cap open android
}

function RPIosBuild(){
    ionic build
    npx cap update ios
    npx cap copy ios
    npx cap open ios
}

function RPSetup(){
    nvm install-latest-npm
    npm uninstall -g @ionic/cli
    npm install -g @ionic/cli
    npx cap add ios
    npx cap add android
}

alias RP-android="RP-refresh RPAndroidBuild"
alias RP-browser="RP-refresh RPBrowserBuild"
alias RP-ios="RP-refresh RPIosBuild"
alias RP-path="cd ~/git/ResidentPlus/"
alias RP-refresh='f(){ unset "$@" && source ~/.bash_aliases && clear && RP-path && "$@"; unset -f f; }; f'
alias RP-setup="RP-refresh RPSetup"
