# Disables the extra env variable printing.
 if [[ $(uname -s) == Linux  ]]; then
     alias ls='ls --group-directories-first --color=auto'
 else
     alias ls='ls -G'
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

# Git
if [ -f ~/.git_aliases ]; then . ~/.git_aliases ; fi

# Additional project aliases
if [ -f ~/.cms_aliases ]; then . ~/.cms_aliases ; fi
if [ -f ~/.rp_aliases ]; then . ~/.rp_aliases ; fi
if [ -f ~/.aptcast_aliases ]; then . ~/.aptcast_aliases ; fi
if [ -f ~/.centerprise_aliases ]; then . ~/.centerprise_aliases ; fi
if [ -f ~/.arapi_aliases ]; then . ~/.arapi_aliases ; fi
