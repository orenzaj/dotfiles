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
alias cmsenv="deactivate; source ~/git/cms/cms-env/bin/activate && cmspath"
alias cmsinstance="startdockers && centenv && centsource"
alias cmsimport="stopdockers && dropdb cms && createdb cms && zcat ~/Downloads/cmsdb/cms.sql.Z | psql -f - cms"
alias cmskill="lsof -i:8000 | grep [p]ython | awk '{print \"kill \"\$2}' | sh"
alias cmsmake="cmsenv && python manage.py makemigrations --noinput"
alias cmsmigrate="cmsenv && python manage.py migrate --noinput"
alias cmspath="cd ~/git/cms/src/247"
alias cmsreimport="cmsdb && cmsimport"
alias cmsserver="cmskill; cmsenv && python manage.py runserver --insecure"
alias cmsshell="cmsenv && python manage.py shell_plus"
alias cmsupdate="cmspath && git pull && cmsmake && cmsmigrate"

# Centerprise
alias centpath="cd ~/git/centerprise/src/"
alias centenv="deactivate; source ~/git/centerprise/cent-env/bin/activate"
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
alias ls='gls --group-directories-first --color=auto'
alias pyclean='find . -type f -name "*.py[co]" -exec rm -f \{\} \;'
alias speedtest="curl -s https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py | python -"
alias whatsmyip="dig +short myip.opendns.com @resolver1.opendns.com"
alias xclip-grab="xclip -i -selection clipboard"

# Git
alias gits="git status -sb"
alias gitm="gits | grep ' M '"
alias gitu="gits | grep '?? '"
alias gitb="gits | grep \"AA\|MM\|UU\""
alias gitd="gits | grep -E \"D\\s\""

# Untracked
alias gitau="gitu | awk '{print \"git add \"\$2}' | sh"
alias gitab="gitb | awk '{print \"git add \"\$2}' | sh"
alias gitcou="gitu | awk '{print \"git checkout \-\- \"\$2}' | sh"
alias gitrmu="gitu | awk '{print \"rm -rf \"\$2}' | sh"

# Modified
alias gitam="gitm | awk '{print \"git add \"\$2}' | sh"
alias gitcom="gitm | awk '{print \"git checkout \"\$2}' | sh"
alias gitrmm="gitm | awk '{print \"rm \"\$2}' | sh"

# All
alias gitaa="gits | awk '{print \"git add \"\$2}' | sh"
alias gitcoa="gits | awk '{print \"git checkout \-\- \"\$2}' | sh"
alias gitrma="gits | awk '{print \"rm\"\$2}' | sh"
alias gitrmd="gitd | awk '{print \"git rm \"\$2}' | sh"

# Trello
alias trellopath="cd ~/git/trello/src/"
alias trelloenv="trellopath && source ../trello-env/bin/activate"
