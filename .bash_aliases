function centenv() {
    INVENV=$(python -c 'import sys; print ("1" if hasattr(sys, "real_prefix") else "0")');
    if [ $INVENV = 0 ]; then
        eval centactivate;
    else
        eval centpath;
    fi
};

function cmsenv() {
    INVENV=$(python -c 'import sys; print ("1" if hasattr(sys, "real_prefix") else "0")');
    if [ $INVENV = 0 ]; then
        eval cmsactivate;
    else
        eval cmspath;
    fi
};

function cmslocalsite(){
    DOMAIN="$1";
    if [ $DOMAIN != *".com"* ]; then
        DOMAIN="$1.com";
    fi

    # Set up directories
    NEW_DOMAIN="$1.localsite.viaryland.com";
    TEMPLATE_STORAGE="/home/jorenza/git/cms/src/template_storage/designs"
    rm -rf $TEMPLATE_STORAGE/$NEW_DOMAIN;
    mkdir $TEMPLATE_STORAGE/$NEW_DOMAIN;

    # The first two lines of python code the file to replace.
    LINE1="domain = \"$DOMAIN\"";
    LINE2="new_domain = \"$NEW_DOMAIN\"";


    # Modify django shell script
    DOMAIN_PY="/home/jorenza/git/cms/src/247/test/domain.py"
    sed -i "1s/^.*$/$LINE1/" $DOMAIN_PY;
    sed -i "2s/^.*$/$LINE2/" $DOMAIN_PY;

    # Run django shell script
    eval cmsenv;
    echo "python /home/jorenza/git/cms/src/247/manage.py shell_plus --quiet < $DOMAIN_PY" | sh;
};

# Mongo
alias mongothemelist="mongofiles -h 172.17.0.1 -d apts247_secureapps_themes --prefix=\$(basename \$PWD) --quiet list"
alias mongothemedir="mongothemelist | awk '{print \"mkdir \"\$1}' | cut -d'/' -sf1 | sort -u | sh"
alias mongogetallthemes="mongothemedir && mongothemelist | awk '{print \"mongofiles -h 172.17.0.1 -d apts247_secureapps_themes --prefix=\$(basename \$PWD) get \"\$1}' | sh"
alias mongodesignlist="mongofiles -h 172.17.0.1 -d apts247_secureapps_designs --prefix=\$(basename \$PWD) --quiet list"
alias mongodesigndir="mongodesignlist | awk '{print \"mkdir \"\$2}' | cut -d'/' -sf1 | sort -u | sh"
alias mongogetalldesigns="mongodesigndir && mongodesignlist | awk '{print \"mongofiles -h 172.17.0.1 -d apts247_secureapps_designs --prefix=\$(basename \$PWD) get \"\$1}' | sh"

# CMS
alias cmsactivate="source ~/git/cms/cms-env/bin/activate && cmspath"
alias cmscelery="cmsenv && celery -A celery_init worker --loglevel=debug"
alias cmspulldb='ssh shallowhal "cd /data && cat \$(ls -S1 cms*.gz|head -n 1)"|gzip -d|psql -U jorenza -h 172.17.0.1 -f - cms'
alias cmsreimportdb="stopdockers && dropdb cms && createdb cms && cmspulldb && cmsupdate"
alias cmspulldbext='ssh shallowhalext "cd /data && cat \$(ls -S1 cms*.gz|head -n 1)"|gzip -d|psql -U jorenza -h 172.17.0.1 -f - cms'
alias cmsreimportdbext="stopdockers && dropdb cms && createdb cms && cmspulldbext"
alias cmsdb='scp shallowhal:$(ssh shallowhal ls -dt /data/cms*sql* | head -1) /home/jorenza/Downloads/cmsdb/cms.sql.Z'
alias cmsdup='find . | grep migrations | grep "/[0-9]\+" | grep -v 'pyc' | sed -e "s/\([^/][^/][^/][^/]\)[^/]\+$/\1/" | sort | uniq -c | less'
alias cmsimport="stopdockers && dropdb cms && createdb cms && zcat ~/Downloads/cmsdb/cms.sql.Z | psql -f - cms"
alias cmskill="lsof -i:8000 | grep [p]ython | awk '{print \"kill \"\$2}' | sh"
alias cmsmake="cmsenv && python manage.py makemigrations --noinput"
alias cmsmigrate="cmsenv && python manage.py migrate --noinput"
alias cmspath="cd ~/git/cms/src/247 && pyclean"
alias cmsint="cmspath && cd apps247/integration/"
alias cmsoutbound="cmsint && cd feeds/outbound/"
alias cmsinbound="cmsint && cd feeds/inbound/"
alias cmsdbupdate="cmsdb && cmsimport"
alias cmsstatic="cd ~/git/cms/src/247/staticfiles"
alias cmslessc="cmsstatic && less-watch-compiler cms/less cms/css cms-new-look.less"
alias cmsrmmigs="cmspath; gitmig | xargs rm"
alias cmsserver="cmskill; cmsenv && python manage.py runserver --insecure"
alias cmsshell="cmsenv && python manage.py shell_plus --quiet"
alias cmsupdate="cmspath && git pull && cmsmake && cmsmigrate"
alias cmstest="cmsenv && python manage.py"

#CMS2
alias cms2make="cms2env && python manage.py makemigrations --noinput"
alias cms2migrate=" cms2env && python manage.py migrate --noinput"
alias cms2update="cms2path && git pull && cms2make && cms2migrate"
alias cms2path="cd ~/git/cms/dev/247 && pyclean"
alias cms2rmmigs="cms2path; gitmig | xargs rm"
alias cms2int="cms2path && cd apps247/integration/"
alias cms2outbound="cms2int && cd feeds/outbound/"
alias cms2inbound="cms2int && cd feeds/inbound/"


# Lead Manager
alias lead-manager="cmspath && cd js_apps/cms/lead_manager/"
alias lead-manager-styles="cmsstatic && cd cms/less/style-2/lead-manager"
alias lead-manager-js-compile="lead-manager && npm run watch"
alias lead-manager-less-watch-compile="lead-manager-less-compile && less-watch-compiler --config=/home/jorenza/.config/less-watch-compiler.config.json"
alias lead-manager-less-compile="cmsstatic && cd cms && lessc less/style-2/lead-manager/lead-manager.less css/lead_manager/lead-manager.css && echo 'Initial compile: Complete.'"

# Centerprise CMS
alias centpath="cd ~/git/centerprise/src/"
alias centactivate="source /home/jorenza/git/centerprise/cent-env/bin/activate && centpath"
alias centenvrestart="deactivate; stopdockers && centenv"
alias centcmsbuild="centenv && ./build.py --clean cms-login && startcmsdocker"
alias centcmsrebuild="centenvrestart && ./build.py --use-cache cms-login && startcmsdocker"

alias centcmsstart="centcmsbuild && docker attach dev-centerprise-cms"
alias centcmsrestart="centenvrestart && startcentdocker && startcmsdocker && docker attach dev-centerprise-cms"
alias centcmsopen="docker start dev-centerprise-cms && docker attach dev-centerprise-cms"

# Dockers
alias startcentdocker="docker start dev-centerprise-nginx dev-centerprise-sentry dev-centerprise-cms dev-centerprise-cms-login dev-cms-mailhog dev-cms-redis-server"
alias startcmsdocker="docker start dev-cms-mailhog dev-cms-redis-server"
alias stopdockers="\/etc\/init\.d\/docker restart"

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
