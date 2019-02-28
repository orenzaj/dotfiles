checkEnv(){
    if [ ${VIRTUAL_ENV}  ]; then
        deactivate;
    fi
}

# Mongo
alias mongothemelist="mongofiles -h 172.17.0.1 -d apts247_secureapps_themes --prefix=\$(basename \$PWD) --quiet list"
alias mongothemedir="mongothemelist | awk '{print \"mkdir \"\$1}' | cut -d'/' -sf1 | sort -u | sh"
alias mongogetallthemes="mongothemedir && mongothemelist | awk '{print \"mongofiles -h 172.17.0.1 -d apts247_secureapps_themes --prefix=\$(basename \$PWD) get \"\$1}' | sh"
alias mongodesignlist="mongofiles -h 172.17.0.1 -d apts247_secureapps_designs --prefix=\$(basename \$PWD) --quiet list"
alias mongodesigndir="mongodesignlist | awk '{print \"mkdir \"\$2}' | cut -d'/' -sf1 | sort -u | sh"
alias mongogetalldesigns="mongodesigndir && mongodesignlist | awk '{print \"mongofiles -h 172.17.0.1 -d apts247_secureapps_designs --prefix=\$(basename \$PWD) get \"\$1}' | sh"

# Dockers
alias startdockers="docker start dev-centerprise-nginx dev-centerprise-sentry dev-centerprise-cms dev-centerprise-cms-login"
alias stopdockers="docker ps -q | awk '{print \"docker stop \" \$1}' | sh"

# CMS
alias cmscelery="cmsenv && celery -A celery_init worker --loglevel=debug"
alias cmsdb="curl http://192.168.86.31/cms.sql.gz -o --create-dirs ~/Downloads/cmsdb/cms.sql.Z"
alias cmsenv="$(checkEnv) source ~/git/cms/cms-env/bin/activate && cmspath"
alias cmsinstance="startdockers && centenv && centsource"
alias cmsimport="stopdockers && dropdb cms && createdb cms && zcat ~/Downloads/cmsdb/cms.sql.Z | psql -f - cms"
alias cmskill="lsof -i:8000 | grep [p]ython | awk '{print \"kill \"\$2}' | sh"
alias cmsmake="cmsenv && python manage.py makemigrations --noinput"
alias cmsmigrate="cmsenv && python manage.py migrate --noinput"
alias cmspath="cd ~/git/cms/src/247"
alias cmsreimport="cmsdb && cmsimport"
alias cmsstatic="cd ~/git/cms/src/247/staticfiles"
alias cmslessc="cmsstatic && less-watch-compiler cms/less cms/css cms-new-look.less"
alias cmsrmmigs="cmspath; gitmig | xargs rm"
alias cmsserver="cmskill; cmsenv && python manage.py runserver --insecure"
alias cmsshell="cmsenv && python manage.py shell_plus"
alias cmsupdate="cmspath && git pull && cmsmake && cmsmigrate"

# Lead Manager
alias lead-manager="cmspath && cd js_apps/cms/lead_manager/"
alias lead-manager-styles="cmsstatic && cd cms/less/style-2/lead-manager"
alias lead-manager-js-compile="lead-manager && npm run watch"
alias lead-manager-less-watch-compile="lead-manager-less-compile && less-watch-compiler --config=/home/jorenza/.config/less-watch-compiler.config.json"
alias lead-manager-less-compile="cmsstatic && cd cms && lessc less/style-2/lead-manager/lead-manager.less css/lead_manager/lead-manager.css && echo 'Initial compile: Complete.'"

# Centerprise
alias centpath="cd ~/git/centerprise/src/"
alias centenv="$(checkEnv) source ~/git/centerprise/cent-env/bin/activate"
alias centsource="source ~/git/centerprise/src/development.sh && docker attach dev-centerprise-cms"

# SecureApplications
alias venvsec=". ~/git/secureapps/secure-apps-env/bin/activate"
alias migratesec="python ~/secureapps/manage.py migrate --noinput"
alias runsec="python ~/secureapps/manage.py runserver 0.0.0.0:8080 --insecure"
alias celerysec="cd ~/git/secureapps/src/ && celery -A celery_init worker --loglevel=debug"
# Spider
alias spiderenv=". ~/git/spider/spider-env/bin/activate && spiderpath"
alias spiderpath="cd ~/git/spider/src/apts247"
alias spiderrun="spiderclean && spiderenv && scrapy runspider apts247/spiders/247_spider.py && spiderls && spiderpath"
alias spiderclean="cd ~/git/spider/src/apts247/apts247/staticfiles && rm -rf *"
alias spiderls="cd ~/git/spider/src/apts247/apts247/staticfiles && find . -name '*.html' | sort"

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
