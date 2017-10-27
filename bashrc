# APPENDED PATH
export PATH="$HOME/.local/bin:$PATH"

# NAMED PATHS 
CMS="$HOME/Development/cms/"

# ALIASES
alias venvcms=". $CMS/../cms-env/bin/activate"
alias ls="ls --color=auto --group-directories-first"
if [ $TILIX_ID ] || [ $VTE_VERSION ] ; then source /etc/profile.d/vte.sh; fi # Ubuntu Budgie END

