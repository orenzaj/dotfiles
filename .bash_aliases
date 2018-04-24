# Mongo
alias mongothemelist="mongofiles -h 172.17.0.1 -d apts247_secureapps_themes --prefix=\$(basename \$PWD) --quiet list"
alias mongothemedir="mongothemelist | awk '{print \"mkdir \"\$1}' | cut -d'/' -sf1 | sort -u | sh"
alias mongogetallthemes="mongothemedir && mongothemelist | awk '{print \"mongofiles -h 172.17.0.1 -d apts247_secureapps_themes --prefix=\$(basename \$PWD) get \"\$1}' | sh"
alias mongodesignlist="mongofiles -h 172.17.0.1 -d apts247_secureapps_designs --prefix=\$(basename \$PWD) --quiet list"
alias mongodesigndir="mongodesignlist | awk '{print \"mkdir \"\$2}' | cut -d'/' -sf1 | sort -u | sh"
alias mongogetalldesigns="mongodesigndir && mongodesignlist | awk '{print \"mongofiles -h 172.17.0.1 -d apts247_secureapps_designs --prefix=\$(basename \$PWD) get \"\$1}' | sh"

# Dockers
alias startdockers="docker start dev-centerprise-nginx dev-centerprise-sentry dev-centerprise-cms dev-centerprise-cms-login"
alias stopdockers="docker stop dev-centerprise-cms-login dev-centerprise-cms dev-centerprise-sentry dev-centerprise-nginx"

# CMS
alias cmscelery="cmsenv && celery -A celery_init worker --loglevel=debug"
alias cmsdb="curl http://192.168.86.5/cms.sql.gz -o ~/Downloads/cms.sql.Z"
alias cmsenv="source ~/git/cms/cms-env/bin/activate && cmspath"
alias cmsinstance="startdockers && centenv && centsource"
alias cmsimport="dropdb cms && createdb cms && zcat cms.sql.Z | psql -f - cms" 
alias cmskill="kill \$(lsof -i:8000 | grep '[p]ython') | awk '{print \$2}'"
alias cmsmake="cmsenv && python manage.py makemigrations --noinput"
alias cmsmigrate="cmsenv && python manage.py migrate --noinput"
alias cmspath="cd ~/git/cms/src/247"
alias cmsreimport="cmsdb && cmsimport"
alias cmsserver="cmsenv && python manage.py runserver --insecure"
alias cmsshell="cmsenv && python manage.py shell_plus"

# Centerprise
alias centpath="cd ~/git/centerprise/src/"
alias centenv="source ~/git/centerprise/cent-env/bin/activate"
alias centsource="source ~/git/centerprise/src/development.sh && docker attach dev-centerprise-cms"

# SecureApplications
alias venvsec=". ~/git/secureapps/secure-apps-env/bin/activate"
alias migratesec="python ~/secureapps/manage.py migrate --noinput"
alias runsec="python ~/secureapps/manage.py runserver 0.0.0.0:8080 --insecure"
alias celerysec="cd ~/git/secureapps/src/ && celery -A celery_init worker --loglevel=debug"

# Celery Debugger
alias rdb="telnet localhost 6900"

# Misc
alias pyclean='find . -type f -name "*.py[co]" -exec rm -f \{\} \;'
alias speedtest="curl -s https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py | python -"
alias xclip-grab="xclip -i -selection clipboard"
