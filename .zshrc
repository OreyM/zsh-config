# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/home/orey/.oh-my-zsh"

# Директория по умолчанию
cd /var/www

### Theme ###
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="powerlevel9k/powerlevel9k"
POWERLEVEL9K_MODE="nerdfont-complete"
#POWERLEVEL9K_DISABLE_RPROMPT=true
POWERLEVEL9K_PROMPT_ON_NEWLINE=true
POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX="▶ "
#POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX="↳ "
POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX=""

ENABLE_CORRECTION="true"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

### Plugins ###
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
plugins=(
    git 
    npm 
    vagrant 
    composer 
    sudo 
    web-search 
    laravel5
    docker
    colored-man-pages
)

source $ZSH/oh-my-zsh.sh

### Alias ###
# BASH
alias c='clear'
alias x='exit'
alias i='sudo apt install'
alias my-icc="xrandr | sed -n 's/ connected.*//p' | xargs -n1 -tri xrandr --output {} --brightness 1 --gamma 1:1:1"
alias group='vs /etc/group'

# Visual Code
alias vs='/snap/bin/code'

# MC Edit
alias edit='mcedit'
# alias edit='/usr/local/Cellar/midnight-commander/4.8.22/bin/mcedit'

#PHP Storm
alias storm='phpstorm'

# ZSH Config
alias zconf="code ~/.zshrc"
alias ohmyzsh="cd ~/.oh-my-zsh"
alias sourcezsh='source ~/.zshrc'

# OS param
alias os='screenfetch'

#DIR Alias
alias vpath="cd ~/Google/WEB_DEV/_localServer/domains"
alias localpath="cd ~/domain/"
alias project="cd ~/_project/"
alias dockpath="cd ~/_docker/"

#GIT Alias
alias status='git status'
alias add='git add .'
alias push='git push origin master'
alias pull='git pull'
# glog

# PHP
alias phpini="cd /usr/local/etc/php/" # + vers PHP, ex 7.3

### Apache alias ###
# Управление сервером
alias apache-status='sudo service apache2 status'
alias apache-start='sudo service apache2 start'
alias apache-restart='sudo service apache2 restart'
alias apache-stop='sudo service apache2 stop'
# Вывести список всех виртуальных сайтов
apache-hosts() {
    cd /var/www
    apache2 -v
    echo "\n"
    declare -a dirs=(*/)
    for dir in "${dirs[@]}"; 
    do  
        var=${dir%/}
        echo "<[ \x1b[0;32m http://$var \x1b[0m ]>"; 
    done
    echo "\n"
}
alias apache-error-check='apache2ctl -t'
# Создаем новую директорию для сайта
# apache-make-site $SITE_NAME $USER
apache-make-site() {
    SITE_NAME=$1
    USER=$(whoami)
    if [ -z "$SITE_NAME" ]; then
        # Не указано имя сайта первым параметром
        echo "\x1b[1;31mНе задано имя сайта [apache-make-site SITE_NAME USER]\x1b[0m"
    elif [ -z "$USER" ]; then
        # Не указан пользователь вторым параметром
        echo "\x1b[1;31mНе задан пользователь, для назначения прав [apache-make-site SITE_NAME USER]\x1b[0m"
        user=$(whoami)
        echo "\x1b[0;37;44mТекущий пользователь:\x1b[0m $user"
    else
        if [ -d /var/www/"$SITE_NAME".local ]; then
            # Существует ли уже такой сайт
            echo "\x1b[1;31mСайт $SITE_NAME.local уже существует, выберите другое имя\n\x1b[0m"
            curl -Is http://"$SITE_NAME".local
        else 
            # Создаем новую директорию для сайта
            sudo mkdir -p "/var/www/$SITE_NAME.local/public"
            # Копируем тестовую стартовую страницу index.php
            # sudo cp /var/www/index.php "/var/www/$SITE_NAME.local/public/"
            # Назначаем права на директорию сайта
            sudo chown -R "$USER":"$USER" /var/www/"$SITE_NAME".local
            # Создаем новый кофигурационный файл
            sudo touch "/etc/apache2/sites-available/$SITE_NAME.local.conf"
            # Конфигурация
            if [ ! -d ~/.custom_domain/_site_config ]; then
                mkdir -p ~/.custom_domain/_site_config
            fi
            touch ~/.custom_domain/_site_config/"$SITE_NAME".local.conf
            echo "<VirtualHost *:80>
    ServerAdmin admin@$SITE_NAME.local
    ServerName $SITE_NAME.local
    ServerAlias www.$SITE_NAME.local
    DocumentRoot /var/www/$SITE_NAME.local/public
    ErrorLog \${APACHE_LOG_DIR}/$SITE_NAME.error.log
    CustomLog \${APACHE_LOG_DIR}/$SITE_NAME.access.log combined
</VirtualHost>
# vim: syntax=apache ts=4 sw=4 sts=4 sr noet" > ~/.custom_domain/_site_config/"$SITE_NAME".local.conf
            sudo cp ~/.custom_domain/_site_config/"$SITE_NAME".local.conf /etc/apache2/sites-available/"$SITE_NAME".local.conf
            # Подключаем сайт в Apache
            sudo a2ensite "$SITE_NAME.local.conf"
            # Добавляем хост
            sudo sed -i "$ a 127.0.1.1	$SITE_NAME.local" "/etc/hosts" 
            # Перезагружаем Apache
            sudo service apache2 restart
            echo -e "The server was rebooted\n"
            curl -Is http://"$SITE_NAME".local
            cd /var/www/"$SITE_NAME".local
            vs /var/www/"$SITE_NAME".local
        fi
    fi
}
# Удаляем сайт
apache-delete-site() {
    SITE_NAME=$1

    if [ -z "$SITE_NAME" ]; then
        # Не указано имя сайта первым параметром
        echo "\x1b[1;31mНе задано имя сайта, который необходимо удалить [apache-delete-site SITE_NAME]\x1b[0m"
    else
        if [ -d /var/www/"$SITE_NAME".local ]; then
            # Удаляем диреткорию с сайтом
            sudo rm -rf "/var/www/$SITE_NAME.local"
            # Удаляем конфигурационный файл сайта
            sudo rm "/etc/apache2/sites-available/$SITE_NAME.local.conf"
            # Отключаем сайт от сервера
            sudo a2dissite "$SITE_NAME.local.conf"
            # Убираем адресс сайта из хоста
            sudo sed -i "/127.0.1.1	$SITE_NAME.local/d" "/etc/hosts"
            # Перезагружаем Apache
            sudo service apache2 restart
            echo -e "\x1b[1;42mСайт удален. Сервер перезагружен\x1b[0m\n"
        else
            echo "\x1b[1;31mСайт $SITE_NAME.local НЕ существует, проверте имя\n\x1b[0m"
        fi
    fi
}

# Laravel
alias laravel="~/.composer/vendor/bin/laravel"
alias larperm='sudo chgrp -R www-data storage bootstrap/cache; sudo chmod -R ug+rwx storage bootstrap/cache'
alias lara='php artisan'
alias serve='php artisan serve'
alias controller='php artisan make:controller'
alias model='php artisan make:model'
alias migration='php artisan make:migration'
alias migrate='php artisan migrate'
alias refresh='php artisan migrate:refresh --seed'
alias routelist='php artisan route:list'

# laravel-create-project PROJECT_NAME VERSION
laravel-create-project(){
    PROJECT_NAME=$1;
    VERSION=$2
    USER=$(whoami)

    if [ -z "$PROJECT_NAME" ]; then
        # Не указано имя сайта первым параметром
        echo "\x1b[1;31mНе задано имя сайта [laravel-create-project PROJECT_NAME VERSION]\x1b[0m"
    elif [ -z "$VERSION" ]; then
        echo "\x1b[1;31mНе указана версия пакета Laravel [laravel-create-project PROJECT_NAME VERSION]\x1b[0m"
    else
        if [ -d /var/www/"$PROJECT_NAME".local ]; then
            echo "\x1b[1;31mСайт $PROJECT_NAME.local уже существует, выберите другое имя\n\x1b[0m"
            curl -Is http://"$PROJECT_NAME".local
        else 
            sudo chown -R "$USER":"$USER" /var/www
            cd "/var/www/"
            composer create-project laravel/laravel="$VERSION.*" "$PROJECT_NAME".local
            sudo chown -R "$USER":"$USER" /var/www/"$PROJECT_NAME".local
            sudo touch "/etc/apache2/sites-available/$PROJECT_NAME.local.conf"
            if [ ! -d ~/.custom_domain/_site_config ]; then
                mkdir -p ~/.custom_domain/_site_config
            fi
            touch ~/.custom_domain/_site_config/"$PROJECT_NAME".local.conf
            echo "<VirtualHost *:80>
        ServerAdmin admin@$PROJECT_NAME.local
        ServerName $PROJECT_NAME.local
        ServerAlias www.$PROJECT_NAME.local
        DocumentRoot /var/www/$PROJECT_NAME.local/public
        ErrorLog \${APACHE_LOG_DIR}/$PROJECT_NAME.error.log
        CustomLog \${APACHE_LOG_DIR}/$PROJECT_NAME.access.log combined
    </VirtualHost>
    # vim: syntax=apache ts=4 sw=4 sts=4 sr noet" > ~/.custom_domain/_site_config/"$PROJECT_NAME".local.conf
            sudo cp ~/.custom_domain/_site_config/"$PROJECT_NAME".local.conf /etc/apache2/sites-available/"$PROJECT_NAME".local.conf
            sudo a2ensite "$PROJECT_NAME.local.conf"
            sudo sed -i "$ a 127.0.1.1	$PROJECT_NAME.local" "/etc/hosts" 
            sudo service apache2 restart
            echo -e "The server was rebooted\n"
            cd /var/www/"$PROJECT_NAME".local
            sudo chmod 777 -R storage && sudo chmod 777 -R bootstrap/cache
            composer require --dev barryvdh/laravel-ide-helper
            composer require barryvdh/laravel-debugbar --dev
            npm install
            npm run dev  
            php artisan cache:clear
            echo "\n"
            echo "\x1b[0;32mNode ver:\x1b[0m" $(node --version)
            echo "\x1b[0;32mNPM ver:\x1b[0m" $(npm --version)
            composer --version
            php -v
            php artisan --version
            echo "\n"
            curl -Is http://"$SITE_NAME".local
            echo "\n"
            echo "\x1b[0;32mLaravel development server started:\x1b[0m <[ http://$PROJECT_NAME.local ]>"
            vs /var/www/"$PROJECT_NAME".local
            echo "\n"
        fi
    fi
}

### Docker ###
alias dres='sudo service docker restart'
alias dimg='docker images'
alias dcont='docker ps -a'
alias dstart='docker start'
alias dstop='docker stop'
alias dstop-all=''
alias ddelete='docker rm'
alias ddelete-all='docker rm -v $(docker ps -aq -f status=exited)'
alias ddelete-image='docker rmi -f'
# Docker compose
alias dcup='docker-compose up'
alias dcdown='docker-compose stop'

dcommit(){
    MYAPP="$1"
    USER="$2"
    IMAGE="$3"

    docker commit "$MYAPP" "$USER"/"$IMAGE"
}
dpush(){
    USER="$1"
    IMAGE="$2"

    docker push "$USER"/"$IMAGE"
}

# laradock
## https://github.com/Laradock/laradock.git
# DB_HOST=mysql
# REDIS_HOST=redis
# QUEUE_HOST=beanstalkd
alias laradock='git clone https://github.com/Laradock/laradock.git'
alias laradockenv='cp env-example .env'
alias ldbash='docker-compose exec --user=laradock workspace bash'
alias ldserve='docker-compose up -d nginx mysql phpmyadmin redis workspace'
alias ldstop='docker-compose stop'
alias ldwork='docker-compose exec --user=laradock workspace bash'

#NPM
alias ndev='npm run dev'
alias nprod='npm run prod'
alias nwatch='npm run watch'

#PHPUnit Alias
alias testy='vendor/bin/phpunit --colors=always'

# Обновляем конфигурацию ZSH в репозитории [gitzsh $COMMIT]
gitzsh() {
    if [ -z "$1" ]; then
        echo "\x1b[1;31mНе добавлен коммит для git [gitzsh 'COMMIT']\x1b[0m"
    else
        cp ~/.zshrc ~/Project/_zsh/.zshrc
        cd ~/Project/_zsh
        git add .
        git commit -m "$1"
        git push -u origin master
    fi
}

# Sources
source /home/orey/.zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
