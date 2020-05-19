function devenv() {
    # Usage: devenv <env_name> [options]
    # Options:
    #   -a          Force to activate an environment (default)
    #   -d          Force to deactivate an environment
    #   -t          Force to toggle an environment
    if [[ -n $1 ]]; then
        local CURRENV=$(python -c 'import sys; print(getattr(sys, "prefix", "").split("/")[-1])');
        if [[ -n $CURRENV ]]; then
            local DEACTIVATE=$(echo "$@" | grep -e '-d')
            if [[ -n $DEACTIVATE ]]; then
                source deactivate 2> /dev/null
            else
                local TOGGLE=$(echo "$@" | grep -e '-t')
                if [[ -n $TOGGLE ]]; then
                    source deactivate 2> /dev/null
                fi
                local ENVNAME=$(echo $1 | sed 's/-//' | awk -F 'env' '{print $1"-env"}');
                if [[ $CURRENV != $ENVNAME ]]; then
                    pyenv activate $ENVNAME
                    local ENVPATH=$(echo $ENVNAME | sed 's/-env/path/');
                    eval $ENVPATH
                fi
            fi
        fi
    fi
}

function cmsreimportdb() {
    eval restartdockers

    if [ -f "$HOME/.ssh/config" ]; then
        local SERVERIDX;
        echo "Choosing the server to pull the database...";
        sed -n "s/Host//p" ~/.ssh/config | grep -iv name | awk '{print "    ["NR"]", $1}'
        read -p "Please enter the corresponding number: " SERVERIDX;

        local SERVERCOUNT=$(sed -n "s/Host//p" ~/.ssh/config | grep -iv name | awk '{print "    ["NR"]", $1}' | wc -l);
        if [ $SERVERIDX -gt 0 ] && [ $SERVERIDX -le $SERVERCOUNT ]; then
            local CHOSENSERVER=$(sed -n "s/Host//p" ~/.ssh/config | grep -iv name | awk '{print "    ["NR"]", $1}' | grep $SERVERIDX | awk '{print $2}');
        else
            echo "Invalid input.";
            return;
        fi
    else
        local $SERVERIP;
        local $SERVERUSER;
        local $SERVERPORT;
        read -p "Please enter the IP address of the server: " $SERVERIP;
        read -p "Please enter your username for the server: " $SERVERUSER;
        read -p "Please enter the port of the server: " $SERVERPORT;
        local CHOSENSERVER="$SERVERUSER@$SERVERIP:$SERVERPORT";
    fi
    CMS_DB_SERVER_LOCATION=$CHOSENSERVER;

    echo -e "\nGrabbing CMS database info your local.py\n..."
    eval cmspath
    cd settings
    CMS_PSQL_DB=$(grep -o '"NAME.*"' local.py | awk '{print $2}' | sed 's/"//g')
    CMS_PSQL_USER=$(grep -o '"USER.*"' local.py | awk '{print $2}' | sed 's/"//g')
    CMS_PSQL_HOST=$(grep -o '"HOST.*"' local.py | awk '{print $2}' | sed 's/"//g')

    if [ -z "$CMS_PSQL_DB" ] || [ -z "$CMS_PSQL_USER" ] || [ -z "$CMS_PSQL_HOST" ]; then
        echo -e "\nUnable to grab required information from local.py."
        echo -e "\nPlease enter the following information (found in local.py) to reimport your cms database:"
        read -p "CMS Database Name: " CMS_PSQL_DB;
        read -p "CMS Username: " CMS_PSQL_USER;
        read -p "CMS Host: " CMS_PSQL_HOST;
    fi
    echo "Done."

    echo -e "\nFinding latest database dump in '$CMS_DB_SERVER_LOCATION'\n...";
    local FINDDB_CMD="find /data/db -name \x24(ls -1St /data/db | head -1)"
    local FINDDB="ssh $CMS_DB_SERVER_LOCATION '$FINDDB_CMD'"
    echo -e "Found: $(echo -e $FINDDB | sh)"

    local RAWDB_CMD="'$FINDDB_CMD | xargs cat'";
    local RAWDB="ssh $CMS_DB_SERVER_LOCATION $RAWDB_CMD"
    local UNZIPDB_CMD="gzip -d | psql -U $USER -h 172.17.0.1 -f - cms"
    local REIMPORT_CMD="$RAWDB | $UNZIPDB_CMD"

    echo -e "\nKilling the cms\n...";
    eval cmskill;
    echo -e "Killed.";

    echo -e "\nReinitializing database '$CMS_PSQL_DB'\n...";
    dropdb $CMS_PSQL_DB;
    createdb $CMS_PSQL_DB;
    echo -e "Reinitialized.";

    echo -e "\nRemporting '$CMS_PSQL_DB' database using the following command:";
    echo -e "$REIMPORT_CMD | sh";
    echo -e $REIMPORT_CMD | sh
    eval cmsupdate;
}

# function cmsimportbyssh() {
# }

# function cmsimportbylocaldb() {
# }

# Mongo
alias mongothemelist="mongofiles -h 172.17.0.1 -d apts247_secureapps_themes --prefix=\$(basename \$PWD) --quiet list"
alias mongothemedir="mongothemelist | awk '{print \"mkdir \"\$1}' | cut -d'/' -sf1 | sort -u | sh"
alias mongogetallthemes="mongothemedir && mongothemelist | awk '{print \"mongofiles -h 172.17.0.1 -d apts247_secureapps_themes --prefix=\$(basename \$PWD) get \"\$1}' | sh"
alias mongodesignlist="mongofiles -h 172.17.0.1 -d apts247_secureapps_designs --prefix=\$(basename \$PWD) --quiet list"
alias mongodesigndir="mongodesignlist | awk '{print \"mkdir \"\$2}' | cut -d'/' -sf1 | sort -u | sh"
alias mongogetalldesigns="mongodesigndir && mongodesignlist | awk '{print \"mongofiles -h 172.17.0.1 -d apts247_secureapps_designs --prefix=\$(basename \$PWD) get \"\$1}' | sh"

# CMS
alias cmsenv="devenv cms -a"
alias cmscelery="cmsenv && celery -A celery_init worker --loglevel=debug"
alias cmsdb="restartdockers && cmsdbimporter"
alias cmsdup='find . | grep migrations | grep "/[0-9]\+" | grep -v 'pyc' | sed -e "s/\([^/][^/][^/][^/]\)[^/]\+$/\1/" | sort | uniq -c | less'
alias cmskill="lsof -i:8000 | grep [p]ython | awk '{print \"kill \"\$2}' | sh"
alias cmsmake="cmsenv && python manage.py makemigrations --noinput"
alias cmsmigrate="cmsenv && python manage.py migrate --noinput"
alias cmspath="cd ~/git/cms/src/247 && pyclean"
alias cmsint="cmspath && cd apps247/integration/"
alias cmsoutbound="cmsint && cd feeds/outbound/"
alias cmsinbound="cmsint && cd feeds/inbound/"
alias cmsstatic="cd ~/git/cms/src/247/staticfiles"
alias cmslessc="cmsstatic && less-watch-compiler cms/less cms/css cms-new-look.less"
alias cmsrmmigs="cmspath; gitmig | xargs rm"
alias cmsserver="cmskill; cmsenv && python manage.py runserver --insecure"
alias cmsshell="cmsenv && python manage.py shell_plus --quiet"
alias cmsupdate="cmspath && git pull && cmsmake && cmsmigrate"
alias cmstest="cmsenv && python manage.py"
alias cmslocalpy="cmspath && vim settings/local.py"
alias cmsmongo="mongod --bind_ip 172.17.0.1 &"
alias cmsredis="redis-server --bind 172.17.0.1 &"

# Lead Manager
alias lead-manager="cmspath && cd js_apps/cms/lead_manager/"
alias lead-manager-styles="cmsstatic && cd cms/less/style-2/lead-manager"
alias lead-manager-js-compile="lead-manager && npm run watch"
alias lead-manager-less-watch-compile="lead-manager-less-compile && less-watch-compiler --config=/home/jorenza/.config/less-watch-compiler.config.json"
alias lead-manager-less-compile="cmsstatic && cd cms && lessc less/style-2/lead-manager/lead-manager.less css/lead_manager/lead-manager.css && echo 'Initial compile: Complete.'"

# Dockers
alias startcentdocker="docker start dev-centerprise-nginx dev-centerprise-sentry dev-centerprise-cms dev-centerprise-cms-login"
alias startcmsdocker="docker start dev-cms-mailhog dev-cms-redis-server"
alias restartdockers="\/etc\/init\.d\/docker restart"
alias stopdockers="\/etc\/init\.d\/docker stop"

# Centerprise CMS
alias centpath="cd ~/git/centerprise/src/"
alias centactivate="pyenv activate cent-env && centpath"
alias centcmsbuild="devenv cent && ./build.py --clean cms-login"
alias centcmsrebuild="restartdockers && devenv cent && ./build.py --use-cache cms-login && startcmsdocker"
alias centcmsstart="centcmsbuild && centcmsattach"
alias centcmsrestart="restartdockers && devenv cent && startcentdocker && centcmsattach"
alias centcmsattach="docker attach dev-centerprise-cms"

# Repo updates
alias leasingportalupdate="backsassupdate && gogogadgetupdate && jsonbornupdate && portalupdate"
alias portalupdate="portalpath && git pull"
alias jsonbornupdate="jsonbornpath && git pull"
alias backsassupdate="backsasspath && git pull"
alias gogogadgetupdate="gogogadgetpath && git pull"

# Repo paths
alias portalpath="centpath && cd cms-images/cms-leasing-portal"
alias jsonbornpath="cd ~/git/centerprise/json-born"
alias backsasspath="cd ~/git/centerprise/back-sass"
alias gogogadgetpath="cd ~/git/centerprise/go-go-gadget"

# Database Reimports
alias portaldbupdate="centpath && dropdb leasingportal && createdb leasingportal && cat cms-images/cms-leasing-portal/sql/createdb.sql | psql -f - leasingportal"

# Start Servers
alias startserver='f(){ unset "$@" && source ~/.bash_aliases && clear && "$@"; unset -f f; }; f'
alias startirlurl="startserver irlurlserver"
alias startportal="startserver portalserver"
alias startportalapi="startserver apiconvergenceserver"
alias startnginxwebsiteruntime="startserver nginxwebsiteruntimeserver"

# Build servers
alias apiconvergencebuild="go build github.com/Apartments24-7/centerprise/cms-images/api-convergence"
alias irlserverbuild="go build github.com/Apartments24-7/centerprise/local-only-images/irl-urls"
alias portalbuild="go build github.com/Apartments24-7/centerprise/cms-images/cms-leasing-portal"
alias nginxwebsiteruntimebuild="go build github.com/Apartments24-7/centerprise/misc-images/nginx-website-runtime"

# Rebuild servers
alias apiconvergencerebuild="rm api-convergence; go build -a github.com/Apartments24-7/centerprise/cms-images/api-convergence"
alias irlserverrebuild="rm irl-urls; go build -a github.com/Apartments24-7/centerprise/local-only-images/irl-urls"
alias portalrebuild="rm cms-leasing-portal; go build -a github.com/Apartments24-7/centerprise/cms-images/cms-leasing-portal"
alias nginxwebsiteruntimerebuild="rm nginx-website-runtime; go build -a github.com/Apartments24-7/centerprise/misc-images/nginx-website-runtime"

# Run servers
function irlurlserver() {
    devenv cent;
    local IRLURLPORT=3001;
    local CENTSRC="/home/jorenza/go/src/github.com/Apartments24-7/centerprise";
    eval killserver $IRLURLPORT;
    eval irlserverbuild;
    VERBOSE=1 ./irl-urls \
        --irl-domain 247.freedomfloorplans.apartments \
        --git-data-dir "$CENTSRC/test" \
        --listen-address :$IRLURLPORT \
        --render base
        # --irl-domain 247.mediamanager.apartments \
    }

function portalserver() {
    devenv cent;
    local APICONVERGENCEPORT=7000;
    local CMSPORT=8000;
    local PORTALPORT=8080;
    local CENTSRC="/home/jorenza/go/src/github.com/Apartments24-7/centerprise";
    eval killserver $PORTALPORT;
    eval portalbuild;

        # --access-log-enabled \
    VERBOSE=1 ./cms-leasing-portal \
        -k "dev" \
        --api-convergence-url "http://127.0.0.1:$APICONVERGENCEPORT/api-convergence/" \
        --aptexx-v2-api-token 1ISHSZPTB3C9XE7Q \
        --aptexx-v2-callback-url https://fees1.apts247.us \
        --aptexx-v2-payment-domain clientsandbox.aptx.cm \
        --cms-247-host "dev.viaryland.com:$CMSPORT" \
        --cms-leasing-host "247.apts247.us:$PORTALPORT" \
        --disable-json-born-cache \
        --disable-kms \
        --disable-manager-email \
        --disable-template-updates \
        --disable-tls-cms \
        --disable-tls-leasing-portal \
        --email-port "1025" \
        --email-server "172.17.0.1" \
        --git-data-dir "$CENTSRC/test" \
        --portal-leasing-host "portal.apts247.us:$PORTALPORT" \
        --view-leasing-host "dev.viaryland.com"
    }

function apiconvergenceserver() {
    devenv cent;
    local APICONVERGENCEPORT=7000
    eval killserver $APICONVERGENCEPORT;
    eval apiconvergencebuild;
    VERBOSE=1 ./api-convergence \
        -k dev \
        --listen-address 127.0.0.1:$APICONVERGENCEPORT
    }

function nginxwebsiteruntimeserver() {
    devenv cent;
    local APICONVERGENCEPORT=7000
    eval nginxwebsiteruntimebuild;
    VERBOSE=1  ./nginx-website-runtime \
        -k dev \
        --api-convergence-url http://127.0.0.1:$APICONVERGENCEPORT/api-convergence/ \
        --spider-domains localsite.viaryland.com,
    }

# Kill servers
function killserver() {
    if [[ ! -z "$1" ]]; then
        local KILLCMD=$(lsof -i :$1 | grep $USER | awk '{ print $2 }')
        if [[ $KILLCMD ]]; then
            kill -9 $KILLCMD
        fi
    fi
}

# Test portal
function testportal() {
    eval portalpath;
    local CENTSRC="/home/jorenza/go/src/github.com/Apartments24-7/centerprise";
    KEY_PATH=$CENTSRC/dev/ GIT_DATA_DIR=$CENTSRC/test/ go test -v -coverprofile cover.out .
    go tool cover -html=cover.out -o cover.html
}

# Celery Debugger
alias rdb="telnet localhost 6900"

# Disables the extra env variable printing.
if [[ $(uname -s) == Linux  ]]; then
    alias ls='ls --group-directories-first --color=auto'
else
    alias ls='gls --group-directories-first --color=auto'
fi

# Misc
alias dotfiles="cd ~/git/dotfiles"
alias pyclean='find . -type f -name "*.py[co]" -exec rm -f \{\} \;'
alias speedtest="curl -s https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py | python -"
alias whatsmyextip="dig +short myip.opendns.com @resolver1.opendns.com | awk '{print \"external: \"\$1}'"
alias whatsmylocalip="ifconfig | grep 'inet ' | awk '{print \"local: \"\$2}' | cut -f1 -d'/'"
alias whatsmyip="whatsmylocalip && whatsmyextip"
alias xclip-grab="xclip -i -selection clipboard"
